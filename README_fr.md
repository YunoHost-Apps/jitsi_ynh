<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# Jitsi Meet pour YunoHost

[![Niveau d’intégration](https://apps.yunohost.org/badge/integration/jitsi)](https://ci-apps.yunohost.org/ci/apps/jitsi/)
![Statut du fonctionnement](https://apps.yunohost.org/badge/state/jitsi)
![Statut de maintenance](https://apps.yunohost.org/badge/maintained/jitsi)

[![Installer Jitsi Meet avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jitsi)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer Jitsi Meet rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

Jitsi Meet est un logiciel libre (Apache) dont Jitsi Videobridge, avec WebRTC Javascript, propose des vidéos-conférences de haute qualité, sécurisées et évolutives.


**Version incluse :** 2.0.10078~ynh1

**Démo :** <https://meet.jit.si/>

## Captures d’écran

![Capture d’écran de Jitsi Meet](./doc/screenshots/screenshot.png)

## Documentations et ressources

- Site officiel de l’app : <https://jitsi.org/>
- Documentation officielle utilisateur : <https://jitsi.org/user-faq/>
- Dépôt de code officiel de l’app : <https://github.com/jitsi/jitsi-meet>
- YunoHost Store : <https://apps.yunohost.org/app/jitsi>
- Signaler un bug : <https://github.com/YunoHost-Apps/jitsi_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche `testing`](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

Pour essayer la branche `testing`, procédez comme suit :

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
ou
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```

**Plus d’infos sur le packaging d’applications :** <https://yunohost.org/packaging_apps>
