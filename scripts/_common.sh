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
