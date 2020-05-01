admins = { "svc__APP__focus@auth.__DOMAIN__" }

cross_domain_bosh = true;
component_ports = { __PORT_COMPONENT__ }

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

allow_registration = false

VirtualHost "__DOMAIN__"
	authentication = "anonymous"
	ssl = {
		key = "/etc/yunohost/certs/__DOMAIN__/key.pem";
		certificate = "/etc/yunohost/certs/__DOMAIN__/crt.pem";
	}

	--c2s_require_encryption = false --why?

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
			filter        = "(&(objectClass=posixAccount)(mail=*@auth.__DOMAIN__))",
			usernamefield = "mail",
			namefield     = "cn",
		},
	}

Component "conference.__DOMAIN__" "muc"

Component "jitsi-videobridge.__DOMAIN__"
    component_secret = "__VIDEOBRIDGE_SECRET__"
Component "focus.__DOMAIN__"
    component_secret = "__FOCUS_SECRET__"
