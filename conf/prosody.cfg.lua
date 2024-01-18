plugin_paths = { "__INSTALL_DIR__/jitsi-meet-prosody/" }

-- domain mapper options, must at least have domain base set to use the mapper
muc_mapper_domain_base = "__DOMAIN__";

external_service_secret = "__TURN_SECRET__";
external_services = {
     { type = "stun", host = "__DOMAIN__", port = 3478 },
     { type = "turn", host = "__DOMAIN__", port = 3478, transport = "udp", secret = true, ttl = 86400, algorithm = "turn" },
     { type = "turns", host = "__DOMAIN__", port = 5349, transport = "tcp", secret = true, ttl = 86400, algorithm = "turn" }
};

cross_domain_bosh = false;
consider_bosh_secure = true;
-- https_ports = { }; -- Remove this line to prevent listening on port 5284

-- https://ssl-config.mozilla.org/#server=haproxy&version=2.1&config=intermediate&openssl=1.1.0g&guideline=5.4
ssl = {
    protocol = "tlsv1_2+";
    ciphers = "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384"
}

unlimited_jids = {
    "__FOCUS_USER__@auth.__DOMAIN__",
    "__VIDEOBRIDGE_USER__@auth.__DOMAIN__"
}

VirtualHost "__DOMAIN__"
    -- enabled = false -- Remove this line to enable this host
    authentication = "ldap"
    ldap_server = "localhost"
    ldap_filter = "(uid=$user)"
    ldap_scope = "subtree"
    ldap_base = "ou=users,dc=yunohost,dc=org"
    ldap_mode = "bind"
    -- Properties below are modified by jitsi-meet-tokens package config
    -- and authentication above is switched to "token"
    --app_id="example_app_id"
    --app_secret="example_app_secret"
    -- Assign this host a certificate for TLS, otherwise it would use the one
    -- set in the global section (if any).
    -- Note that old-style SSL on port 5223 only supports one certificate, and will always
    -- use the global one.
    ssl = {
        key = "/etc/prosody/certs/__DOMAIN__.key";
        certificate = "/etc/prosody/certs/__DOMAIN__.crt";
    }
    av_moderation_component = "avmoderation.__DOMAIN__"
    speakerstats_component = "speakerstats.__DOMAIN__"
    conference_duration_component = "conferenceduration.__DOMAIN__"
    -- we need bosh
    modules_enabled = {
        "bosh";
        "pubsub";
        "ping"; -- Enable mod_ping
        "speakerstats";
        "external_services";
        "conference_duration";
        "muc_lobby_rooms";
        "muc_breakout_rooms";
        "av_moderation";
    }
    c2s_require_encryption = false
    lobby_muc = "lobby.__DOMAIN__"
    breakout_rooms_muc = "breakout.__DOMAIN__"
    main_muc = "conference.__DOMAIN__"
    -- muc_lobby_whitelist = { "recorder.__DOMAIN__" } -- Here we can whitelist jibri to enter lobby enabled rooms

VirtualHost "guest.__DOMAIN__"
    authentication = "anonymous"
    c2s_require_encryption = false

Component "conference.__DOMAIN__" "muc"
    restrict_room_creation = true
    storage = "memory"
    modules_enabled = {
        "muc_meeting_id";
        "muc_domain_mapper";
        "polls";
        --"token_verification";
        "muc_rate_limit";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__" }
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "breakout.__DOMAIN__" "muc"
    restrict_room_creation = true
    storage = "memory"
    modules_enabled = {
        "muc_meeting_id";
        "muc_domain_mapper";
        --"token_verification";
        "muc_rate_limit";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__" }
    muc_room_locking = false
    muc_room_default_public_jids = true

-- internal muc component
Component "internal.auth.__DOMAIN__" "muc"
    storage = "memory"
    modules_enabled = {
        "ping";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__", "__VIDEOBRIDGE_USER__@auth.__DOMAIN__" }
    muc_room_locking = false
    muc_room_default_public_jids = true

VirtualHost "auth.__DOMAIN__"
    ssl = {
        key = "/etc/prosody/certs/auth.__DOMAIN__.key";
        certificate = "/etc/prosody/certs/auth.__DOMAIN__.crt";
    }
    modules_enabled = {
        "limits_exception";
    }
    authentication = "internal_hashed"

-- Proxy to jicofo's user JID, so that it doesn't have to register as a component.
Component "focus.__DOMAIN__" "client_proxy"
    target_address = "__FOCUS_USER__@auth.__DOMAIN__"

Component "speakerstats.__DOMAIN__" "speakerstats_component"
    muc_component = "conference.__DOMAIN__"

Component "conferenceduration.__DOMAIN__" "conference_duration_component"
    muc_component = "conference.__DOMAIN__"

Component "avmoderation.__DOMAIN__" "av_moderation_component"
    muc_component = "conference.__DOMAIN__"

Component "lobby.__DOMAIN__" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_locking = false
    muc_room_default_public_jids = true
    modules_enabled = {
        "muc_rate_limit";
        "polls";
    }
