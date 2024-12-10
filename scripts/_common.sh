#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

_setup_sources() {
    # Download, check integrity, uncompress and patch the source from app.src
    declare -A packages=(
        [jitsi-jicofo]="jicofo"
        [jitsi-meet-prosody]="jitsi-meet/prosody-plugins"
        [jitsi-meet-web]="jitsi-meet"
        [jitsi-videobridge]="jitsi-videobridge"
    )

    for package in "${!packages[@]}"; do
        ynh_safe_rm "$install_dir/${package}"
        ynh_setup_source --dest_dir="$install_dir/temp" --source_id="$package"
        pushd "$install_dir/temp"
            ar x "$package.deb" data.tar.xz
            tar xf data.tar.xz
        popd

        mv "$install_dir/temp/usr/share/${packages[$package]}/" "$install_dir/$package/"
        ynh_safe_rm "$install_dir/temp"
    done

    ynh_setup_source --dest_dir="$install_dir/jitsi-meet-prosody" --source_id=mod_auth_ldap
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
