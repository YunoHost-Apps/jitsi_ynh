#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="openjdk-8-jre-headless|openjdk-11-jre-headless debconf|debconf-2.0 procps uuid-runtime lua-ldap"

if [ $YNH_ARCH == "armhf" ] 
then
	pkg_dependencies_arm="openjdk-8-jre openjdk-8-jre-headless openjdk-8-jdf openjdk-8-jdk-headless \
                          automake autoconf build-essential libtool git maven m4"
    
    pkg_dependencies="$pkg_dependencies $pkg_dependencies_arm"
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
    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java
    tempdir="$(mktemp -d)"

    # prepare jniwrapper compilation
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-armhf

    declare -A packages_arm
    packages_arm[jitsi-sctp]="jitsi-sctp"
    packages_arm[usrsctp]="jitsi-sctp/usrsctp"

    for packages_arm in "${!packages_arm[@]}"
    do
      ynh_setup_source --dest_dir="$tempdir" --source_id=$packages_arm
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
    ynh_secure_remove --file="$final_path/jitsi-videobridge/lib/jniwrapper-native-*.jar"
    mv "$tempdir/jitsi-sctp/jniwrapper/native/target/jniwrapper-native-1.0-SNAPSHOT.jar" "$final_path/jitsi-videobridge/lib/"

    ynh_secure_remove --file="$tempdir"
}


#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
