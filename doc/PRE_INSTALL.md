## Important points before installing

1. **Jitsi** requires a dedicated **root domain**, eg. jitsi.domain.tld
2. **Jitsi** requires the ports TCP/4443 and UDP/10000 to be forwarded to your YunoHost (The same way you forwarded 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)
3. You must first uninstall the Metronome XMPP service: `sudo apt remove metronome`
4. LDAP authentication is activated, only authenticated users to create new conference rooms. Whenever a new room is about to be created, Jitsi Meet will prompt for a user name and password. After the room is created, others will be able to join from anonymous domain.
5. **Jitsi** is configured for 50 users maximum, this number can be increased in the Yunohost config panel
