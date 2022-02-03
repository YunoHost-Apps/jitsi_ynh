## Points importants à préparer avant l'installation

1. **Jitsi** a besoin d'un **domaine racine** dédié, par exemple : jitsi.domain.tld
2. **Jitsi** demande que les ports TCP/4443 et UDP/10000 soient routés vers votre YunoHost (De la même manière que le sont les ports 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)
3. **Jitsi** va arréter et désactiver le service XMPP Metronome.