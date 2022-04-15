#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="openjdk-8-jre-headless|openjdk-11-jre-headless debconf|debconf-2.0 procps uuid-runtime lua-ldap"

if [ $YNH_ARCH == "armhf" ] 
then
	pkg_dependencies_arm="automake autoconf build-essential libtool git maven m4"
	pkg_dependencies="$pkg_dependencies $pkg_dependencies_arm"

	pkg_extra_depedencies_arm="openjdk-8-jre openjdk-8-jre-headless openjdk-8-jdk openjdk-8-jdk-headless"
fi
#=================================================
# PERSONAL HELPERS
#=================================================

ynh_version_gt ()
{
    dpkg --compare-versions "$1" gt "$2"
}

ynh_jniwrapper_armhf ()
{
    
    # set openjdk-8 as default 
    # update-alternatives --set java /usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java
    tempdir="$(mktemp -d)"

    # prepare jniwrapper compilation
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-armhf

    declare -A packages_arm
    packages_arm[jitsi-sctp]="jitsi-sctp"
    packages_arm[usrsctp]="jitsi-sctp/usrsctp/usrsctp"

    for package_arm in "${!packages_arm[@]}"
    do
      ynh_setup_source --dest_dir="$tempdir/${packages_arm[$package_arm]}" --source_id=$package_arm
    done

    # needed to make compile works
    if [ ! -d "$tempdir/jitsi-sctp/jniwrapper/native/src/main/resources/lib/linux-arm/" ]
    then
      mkdir -p $tempdir/jitsi-sctp/jniwrapper/native/src/main/resources/lib/linux-arm/
    fi

    pushd "$tempdir/jitsi-sctp"
      mvn package -DbuildSctp -DbuildNativeWrapper -DdeployNewJnilib -DskipTests
      mvn package	
    popd

    # rm official jniwrapper to copy 
    original_jniwrapper=$(ls $final_path/jitsi-videobridge/lib/jniwrapper-native-*.jar
    ynh_secure_remove --file="$original_jniwrapper"

    mv "$tempdir/jitsi-sctp/jniwrapper/native/target/jniwrapper-native-1.0-SNAPSHOT.jar" "$final_path/jitsi-videobridge/lib/"

    chmod 640 "$final_path/jitsi-videobridge/lib/jniwrapper-native-1.0-SNAPSHOT.jar"
    chown -R $app:$app "$final_path/jitsi-videobridge/lib/jniwrapper-native-1.0-SNAPSHOT.jar"

    ynh_secure_remove --file="$tempdir"
}


#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
