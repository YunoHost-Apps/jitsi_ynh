#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="openjdk-8-jre-headless|openjdk-11-jre-headless debconf|debconf-2.0 procps uuid-runtime"

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
