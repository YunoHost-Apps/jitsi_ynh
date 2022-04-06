# Jitsi Meet pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/jitsi.svg)](https://dash.yunohost.org/appci/app/jitsi) ![](https://ci-apps.yunohost.org/ci/badges/jitsi.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/jitsi.maintain.svg)  
[![Installer Jitsi Meet avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jitsi)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer Jitsi Meet rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Jitsi Meet est un logiciel libre (Apache) dont Jitsi Videobridge, avec WebRTC Javascript, propose des vidéos-conférences de haute qualité, sécurisées et évolutives.


**Version incluse :** 1.0.5913~ynh1

**Démo :** https://meet.jit.si/

## Captures d'écran

![](./doc/screenshots/screenshot.png)

## Avertissements / informations importantes

## Points importants à préparer avant l'installation

1. **Jitsi** a besoin d'un **domaine racine** dédié, par exemple : jitsi.domain.tld
2. **Jitsi** demande que les ports TCP/4443 et UDP/10000 soient routés vers votre YunoHost (De la même manière que le sont les ports 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)
3. **Jitsi** va arréter et désactiver le service XMPP Metronome.
4. L'authentification LDAP est activée, seuls les utilisateurs authentifiés peuvent créer de nouvelles salles de conférence. Chaque fois qu'une nouvelle salle est sur le point d'être créée, Jitsi Meet vous demandera un nom d'utilisateur et un mot de passe. Une fois la salle créée, d'autres personnes pourront la rejoindre à partir d'un domaine anonyme. 
5. **Jitsi** est configuré pour 50 utilisateurs maximum, ce nombre peut être augmenté en allant dans le panneau de configuration Yunohost

## Documentations et ressources

* Site officiel de l'app : https://jitsi.org/
* Documentation officielle utilisateur : https://jitsi.org/user-faq/
* Dépôt de code officiel de l'app : https://github.com/jitsi/jitsi-meet
* Documentation YunoHost pour cette app : https://yunohost.org/app_jitsi
* Signaler un bug : https://github.com/YunoHost-Apps/jitsi_ynh/issues

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
ou
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```

**Plus d'infos sur le packaging d'applications :** https://yunohost.org/packaging_apps