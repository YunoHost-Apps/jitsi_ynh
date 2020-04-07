#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="openjdk-8-jdk|openjdk-11-jdk openjdk-8-jre|openjdk-11-jre maven coturn"

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
