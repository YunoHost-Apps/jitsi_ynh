## Important points before installing

1. **Jitsi** requires a dedicated **root domain**, eg. jitsi.domain.tld
2. **Jitsi** requires you create additionals domains in your DNS and in your YunoHost
  * auth.jitsi.domain.tld
  * conference.jitsi.domain.tld
  * jitsi-videobridge.jitsi.domain.tld
  * focus.jitsi.domain.tld
3. **Jitsi** requires the ports TCP/4443 and UDP/10000 to be forwarded to your YunoHost (The same way you forwarded 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)
