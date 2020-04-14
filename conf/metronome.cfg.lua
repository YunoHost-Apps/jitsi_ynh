component_ports = { __PORT_COMPONENT__ }
c2s_require_encryption = false
s2s_secure_auth = false

plugin_paths = { "__FINAL_PATH__/jitsi-meet-prosody/" }

-- domain mapper options, must at least have domain base set to use the mapper
muc_mapper_domain_base = "__DOMAIN__";

turncredentials_secret = "__TURN_SECRET__";

turncredentials = {
  { type = "stun", host = "__DOMAIN__", port = "443" },
  { type = "turn", host = "__DOMAIN__", port = "443", transport = "udp" },
  { type = "turns", host = "__DOMAIN__", port = "443", transport = "tcp" }
};

cross_domain_bosh = false;
consider_bosh_secure = true;

VirtualHost "__DOMAIN__"
	-- enabled = false -- Remove this line to enable this host
	authentication = "anonymous"
        -- Properties below are modified by jitsi-meet-tokens package config
        -- and authentication above is switched to "token"
        --app_id="example_app_id"
        --app_secret="example_app_secret"
	-- Assign this host a certificate for TLS, otherwise it would use the one
	-- set in the global section (if any).
	-- Note that old-style SSL on port 5223 only supports one certificate, and will always
	-- use the global one.
	ssl = {
		key = "/etc/yunohost/certs/__DOMAIN__/key.pem";
		certificate = "/etc/yunohost/certs/__DOMAIN__/crt.pem";
	}
    speakerstats_component = "speakerstats.__DOMAIN__"
    conference_duration_component = "conferenceduration.__DOMAIN__"
    -- we need bosh
    modules_enabled = {
        "bosh";
        "pubsub";
        "ping"; -- Enable mod_ping
        "speakerstats";
        "turncredentials";
        "conference_duration";
    }
    c2s_require_encryption = false

Component "conference.__DOMAIN__" "muc"
    storage = "null"
    modules_enabled = {
        "muc_meeting_id";
        -- "muc_domain_mapper";
        -- "token_verification";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__" }
    muc_room_locking = false
    muc_room_default_public_jids = true

-- internal muc component
Component "internal.auth.__DOMAIN__" "muc"
    storage = "null"
    modules_enabled = {
      "ping";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__", "__VIDEOBRIDGE_USER__@auth.__DOMAIN__" }

VirtualHost "auth.__DOMAIN__"
	ssl = {
		key = "/etc/yunohost/certs/auth.__DOMAIN__/key.pem";
		certificate = "/etc/yunohost/certs/auth.__DOMAIN__/crt.pem";
	}
	authentication = "ldap2"
	ldap = {
		hostname      = "localhost",
		user = {
			basedn        = "ou=users,dc=yunohost,dc=org",
            filter        = "(&(objectClass=posixAccount)(mail=*@auth.__DOMAIN__)(permission=cn=xmpp.main,ou=permission,dc=yunohost,dc=org))",
			usernamefield = "mail",
			namefield     = "cn",
		},
	}

Component "focus.__DOMAIN__"
    component_secret = "__FOCUS_SECRET__"

Component "speakerstats.__DOMAIN__" "speakerstats_component"
    muc_component = "conference.__DOMAIN__"

Component "conferenceduration.__DOMAIN__" "conference_duration_component"
    muc_component = "conference.__DOMAIN__"
