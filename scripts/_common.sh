#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="openjdk-8-jre-headless|openjdk-11-jre-headless debconf|debconf-2.0 procps uuid-runtime lua-ldap"
pkg_dependencies_arm="automake autoconf build-essential libtool git maven m4"
pkg_extra_dependencies_arm="openjdk-8-jre_8u322-b06-1~deb9u1_armhf.deb \
                            openjdk-8-jre-headless_8u322-b06-1~deb9u1_armhf.deb \
                            openjdk-8-jdf_8u322-b06-1~deb9u1_armhf.deb \
                            openjdk-8-jdk-headless_8u322-b06-1~deb9u1_armhf.deb"

#=================================================
# PERSONAL HELPERS
#=================================================

ynh_version_gt ()
{
    dpkg --compare-versions "$1" gt "$2"
}

ynh_jniwrapper_armhf ()
{
  if [ $YNH_ARCH == "armhf" ] 
  then
    # set openjdk-8 as default 
    sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java
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
    rm "$final_path/jitsi-videobridge/lib/jniwrapper-native-1.0-8-g04269a7.jar"
    mv "$tempdir/jitsi-sctp/jniwrapper/native/target/jniwrapper-native-1.0-SNAPSHOT.jar" "$final_path/jitsi-videobridge/lib/"

    ynh_secure_remove --file="$tempdir"
  fi
}


#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
