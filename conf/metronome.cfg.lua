plugin_paths = { "__FINAL_PATH__/jitsi-meet-prosody/" }

-- domain mapper options, must at least have domain base set to use the mapper
muc_mapper_domain_base = "__DOMAIN__";

turncredentials_secret = "__TURN_SECRET__";

turncredentials = {
  { type = "stun", host = "__DOMAIN__", port = "3478" },
  { type = "turn", host = "__DOMAIN__", port = "3478", transport = "udp" },
  { type = "turns", host = "__DOMAIN__", port = "5349", transport = "tcp" }
};

cross_domain_bosh = false;
consider_bosh_secure = true;
-- https_ports = { }; -- Remove this line to prevent listening on port 5284

-- https://ssl-config.mozilla.org/#server=haproxy&version=2.1&config=intermediate&openssl=1.1.0g&guideline=5.4
--ssl = {
--  protocol = "tlsv1_2+";
--  ciphers = "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384"
--}

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
            "turncredentials";
            "conference_duration";
            "muc_lobby_rooms";
        }
        c2s_require_encryption = false
        lobby_muc = "lobby.__DOMAIN__"
        main_muc = "conference.__DOMAIN__"
        -- muc_lobby_whitelist = { "recorder.__DOMAIN__" } -- Here we can whitelist jibri to enter lobby enabled rooms


Component "conference.__DOMAIN__" "muc"
    --storage = "internal"
    modules_enabled = {
        "muc_meeting_id";
        "muc_domain_mapper";
        -- "token_verification";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__" }
    allow_anonymous_creation = true
    instant_room_on_creation = true
    room_default_config = { whois = "anyone" }

-- internal muc component
Component "internal.auth.__DOMAIN__" "muc"
    --storage = "internal"
    modules_enabled = {
      "ping";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__", "__VIDEOBRIDGE_USER__@auth.__DOMAIN__" }
    allow_anonymous_creation = true
    instant_room_on_creation = true
    room_default_config = { whois = "anyone" }

VirtualHost "auth.__DOMAIN__"
    ssl = {
        key = "/etc/yunohost/certs/auth.__DOMAIN__/key.pem";
        certificate = "/etc/yunohost/certs/auth.__DOMAIN__/crt.pem";
    }
    authentication = "internal_plain"

Component "focus.__DOMAIN__"
    component_secret = "__FOCUS_SECRET__"

Component "speakerstats.__DOMAIN__" "speakerstats_component"
    muc_component = "conference.__DOMAIN__"

Component "conferenceduration.__DOMAIN__" "conference_duration_component"
    muc_component = "conference.__DOMAIN__"

Component "lobby.__DOMAIN__" "muc"
    storage = "cache"
    restrict_room_creation = true
    instant_room_on_creation = true
    room_default_config = { whois = "anyone" }
