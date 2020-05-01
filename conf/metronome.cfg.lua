component_ports = { __PORT_COMPONENT__ }
--c2s_require_encryption = false --Why would it be needed?

plugin_paths = { "__FINAL_PATH__/jitsi-meet-prosody/" }

modules_enabled = {

	-- Generally required
		"roster"; -- Allow users to have a roster. Recommended.
		"saslauth"; -- Authentication for clients. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"disco"; -- Service discovery
 
	-- Not essential, but recommended
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"vcard"; -- Allow users to set vCards
		"pep"; -- Allows setting of mood, tune, etc.
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
		"bidi"; -- Enables Bidirectional Server-to-Server Streams.
 
	-- Nice to have
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"register"; -- Allow users to register on this server using a client and change passwords
		"stream_management"; -- Allows clients and servers to use Stream Management
		"stanza_optimizations"; -- Allows clients to use Client State Indication and SIFT
		"message_carbons"; -- Allows clients to enable carbon copies of messages
		"mam"; -- Enable server-side message archives using Message Archive Management
		"push"; -- Enable Push Notifications via PubSub using XEP-0357
		"lastactivity"; -- Enables clients to know the last presence status of an user
		"adhoc_cm"; -- Allow to set client certificates to login through SASL External via adhoc
		"admin_adhoc"; -- administration adhoc commands
		"bookmarks"; -- XEP-0048 Bookmarks synchronization between PEP and Private Storage
		"sec_labels"; -- Allows to use a simplified version XEP-0258 Security Labels and related ACDFs.
		"privacy"; -- Add privacy lists and simple blocking command support

		-- Other specific functionality
		--"admin_telnet"; -- administration console, telnet to port 5582
		--"admin_web"; -- administration web interface
		"bosh"; -- Enable support for BOSH clients, aka "XMPP over Bidirectional Streams over Synchronous HTTP"
		--"compression"; -- Allow clients to enable Stream Compression
		--"spim_block"; -- Require authorization via OOB form for messages from non-contacts and block unsollicited messages
		--"gate_guard"; -- Enable config-based blacklisting and hit-based auto-banning features
		--"incidents_handling"; -- Enable Incidents Handling support (can be administered via adhoc commands)
		--"server_presence"; -- Enables Server Buddies extension support
		--"service_directory"; -- Enables Service Directories extension support
		--"public_service"; -- Enables Server vCard support for public services in directories and advertises in features
		--"register_api"; -- Provides secure API for both Out-Of-Band and In-Band registration for E-Mail verification
		"websocket"; -- Enable support for WebSocket clients, aka "XMPP over WebSockets"

		-- For Jitsi Meet
		"http_altconnect";
}

-- Make the focus user a global administrator
admins = { "__FOCUS_USER__@auth.__DOMAIN__" }

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
        "pubsub";
        "ping"; -- Enable mod_ping
        "speakerstats";
        "turncredentials";
        "conference_duration";
	"extdisco";
    }
    c2s_require_encryption = false
    external_services = {
        ["__DOMAIN__"] = {
            { type = "stun", port = "4446", trasport = "udp" },
            { type = "stun", port = "4446", trasport = "tcp" }
            { type = "turn", port = "4446", transport = "udp", turn_secret = "__TURN_SECRET__", turn_ttl = "86400" },
            { type = "turns", port = "443", transport = "tcp", turn_secret = "__TURN_SECRET__", turn_ttl = "86400" },
        }
    }

Component "conference.__DOMAIN__" "muc"
    modules_enabled = {
        "muc_meeting_id";
        "muc_domain_mapper";
        -- "token_verification";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__" }
    allow_anonymous_creation = true
    instant_room_on_creation = true
    room_default_whois = "anyone"

-- internal muc component
Component "internal.auth.__DOMAIN__" "muc"
    modules_enabled = {
      "ping";
    }
    admins = { "__FOCUS_USER__@auth.__DOMAIN__", "__VIDEOBRIDGE_USER__@auth.__DOMAIN__" }
    instant_room_on_creation = true
    room_default_whois = "anyone"

VirtualHost "auth.__DOMAIN__"
    ssl = {
        key = "/etc/yunohost/certs/auth.__DOMAIN__/key.pem";
        certificate = "/etc/yunohost/certs/auth.__DOMAIN__/crt.pem";
    }
    storage = "internal"
    authentication = "internal_plain"

Component "focus.__DOMAIN__"
    component_secret = "__FOCUS_SECRET__"

Component "speakerstats.__DOMAIN__" "speakerstats_component"
    muc_component = "conference.__DOMAIN__"

Component "conferenceduration.__DOMAIN__" "conference_duration_component"
    muc_component = "conference.__DOMAIN__"
