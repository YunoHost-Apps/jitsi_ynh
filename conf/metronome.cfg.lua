component_ports = { __PORT_COMPONENT__ }

-- Make the focus user a global administrator
admins = { "__FOCUS_USER__@auth.__DOMAIN__" }

-- c2s_require_encryption = false --Why would it be needed?
-- s2s_secure_auth = false

plugin_paths = { "__FINAL_PATH__/jitsi-meet-prosody/" }

-- domain mapper options, must at least have domain base set to use the mapper
muc_mapper_domain_base = "__DOMAIN__";

cross_domain_bosh = false;
consider_bosh_secure = true;

VirtualHost "__DOMAIN__"
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
        -- "turncredentials";
        "conference_duration";
        "extdisco";
    }
    c2s_require_encryption = false
    external_services = {
        ["__DOMAIN__"] = {
            { type = "stun", port = "4446", trasport = "udp" },
            { type = "stun", port = "4446", trasport = "tcp" },
            { type = "turn", port = "4446", transport = "udp", turn_secret = "__TURN_SECRET__", turn_ttl = "86400" },
            { type = "turns", port = "443", transport = "tcp", turn_secret = "__TURN_SECRET__", turn_ttl = "86400" }
        }
    }

Component "conference.__DOMAIN__" "muc"
    storage = "internal"
    modules_enabled = {
        "muc_meeting_id";
        "muc_domain_mapper";
        -- "token_verification";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__" }
    allow_anonymous_creation = true
    instant_room_on_creation = true
    room_default_config = {
        whois = "anyone";
    }

-- internal muc component
Component "internal.auth.__DOMAIN__" "muc"
    storage = "internal"
    modules_enabled = {
      "ping";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__", "__VIDEOBRIDGE_USER__@auth.__DOMAIN__" }
    instant_room_on_creation = true
    room_default_config = {
        whois = "anyone";
    }

VirtualHost "auth.__DOMAIN__"
    ssl = {
        key = "/etc/yunohost/certs/auth.__DOMAIN__/key.pem";
        certificate = "/etc/yunohost/certs/auth.__DOMAIN__/crt.pem";
    }
    authentication = "internal_plain"

Component "focus.__DOMAIN__"
    component_secret = "__FOCUS_SECRET__"
    
Component "jitsi-videobridge.__DOMAIN__"
    component_secret = "__VIDEOBRIDGE_SECRET__"

Component "speakerstats.__DOMAIN__" "speakerstats_component"
    muc_component = "conference.__DOMAIN__"

Component "conferenceduration.__DOMAIN__" "conference_duration_component"
    muc_component = "conference.__DOMAIN__"
