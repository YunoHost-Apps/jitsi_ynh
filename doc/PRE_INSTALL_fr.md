## Points importants à préparer avant l'installation

1. **Jitsi** a besoin d'un **domaine racine** dédié, par exemple : jitsi.domain.tld
2. **Jitsi** demande que les ports TCP/4443 et UDP/10000 soient routés vers votre YunoHost (De la même manière que le sont les ports 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)
3. Vous devez au préalable désinstaller le service XMPP Metronome : `sudo apt remove metronome`
4. L'authentification LDAP est activée, seuls les utilisateurs authentifiés peuvent créer de nouvelles salles de conférence. Chaque fois qu'une nouvelle salle est sur le point d'être créée, Jitsi Meet vous demandera un nom d'utilisateur et un mot de passe. Une fois la salle créée, d'autres personnes pourront la rejoindre à partir d'un domaine anonyme. 
5. **Jitsi** est configuré pour 50 utilisateurs maximum, ce nombre peut être augmenté en allant dans le panneau de configuration Yunohost
