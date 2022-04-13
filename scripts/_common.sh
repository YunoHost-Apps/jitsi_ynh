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

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
