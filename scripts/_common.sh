#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

_enable_ldap(){	
	sed -i '/    authentication = \"jitsi-anonymous\" -- do not delete me/r ../conf/prosody.cfg-ldap.lua' /etc/prosody/conf.avail/$domain.cfg.lua
	sed -i '/    authentication = \"jitsi-anonymous\" -- do not delete me/d' /etc/prosody/conf.avail/$domain.cfg.lua
	
	
	ynh_config_add --template="prosody.cfg-guest.lua" --destination="../conf/prosody.cfg-guest.lua.patch"
	cat ../conf/prosody.cfg-guest.lua.patch >> /etc/prosody/conf.avail/$domain.cfg.lua
	ynh_safe_rm "../conf/prosody.cfg-guest.lua.patch"
    ynh_store_file_checksum /etc/prosody/conf.avail/$domain.cfg.lua
	
	ynh_config_add --template="jicofo-ldap.conf" --destination="../conf/jicofo-ldap.conf.patch"
	sed -i '/jicofo {/r../conf/jicofo-ldap.conf.patch' /etc/jitsi/jicofo/jicofo.conf
	ynh_safe_rm "../conf/jicofo-ldap.conf.patch"
    ynh_store_file_checksum /etc/jitsi/jicofo/jicofo.conf
	
	ynh_replace --match="// anonymousdomain: 'guest.example.com'," --replace="anonymousdomain: 'guest.$domain'," --file=/etc/jitsi/meet/$domain-config.js
    ynh_store_file_checksum /etc/jitsi/meet/$domain-config.js
	
	ynh_setup_source --dest_dir="/usr/share/jitsi-meet/prosody-plugins" --source_id=mod_auth_ldap
}

ynh_jniwrapper_armhf () {
    # set openjdk-8 as default
    # update-alternatives --set java /usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java
    tempdir="$(mktemp -d)"

    # prepare jniwrapper compilation
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-armhf

    declare -A packages_arm
    packages_arm[jitsi-sctp]="jitsi-sctp"
    packages_arm[usrsctp]="jitsi-sctp/usrsctp/usrsctp"

    for package_arm in "${!packages_arm[@]}"; do
        ynh_setup_source --dest_dir="$tempdir/${packages_arm[$package_arm]}" --source_id=$package_arm
    done

    # needed to make compile works
    if [ ! -d "$tempdir/jitsi-sctp/jniwrapper/native/src/main/resources/lib/linux-arm/" ]; then
        mkdir -p $tempdir/jitsi-sctp/jniwrapper/native/src/main/resources/lib/linux-arm/
    fi

    pushd "$tempdir/jitsi-sctp"
        mvn package -DbuildSctp -DbuildNativeWrapper -DdeployNewJnilib -DskipTests
        mvn package
    popd

    # rm official jniwrapper to copy
    original_jniwrapper=$(ls $install_dir/jitsi-videobridge/lib/jniwrapper-native-*.jar)
    ynh_safe_rm "$original_jniwrapper"

    mv "$tempdir/jitsi-sctp/jniwrapper/native/target/jniwrapper-native-1.0-SNAPSHOT.jar" "$install_dir/jitsi-videobridge/lib/"

    chmod 640 "$install_dir/jitsi-videobridge/lib/jniwrapper-native-1.0-SNAPSHOT.jar"
    chown -R $app:$app "$install_dir/jitsi-videobridge/lib/jniwrapper-native-1.0-SNAPSHOT.jar"

    ynh_safe_rm "$tempdir"
}
