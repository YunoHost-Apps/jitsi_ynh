# Jitsi Meet pour YunoHost

## Avertissements
**Jitsi-meet** pour YunoHost est limité actuellement :
  * Il ne peut être utilisé qu'avec Chrome ou un navigateur basé sur Chromium
  * Il est limité à 2 participants par réunion

Ces limitations viennent de la manière dont l'application a été empaquetée pour YunoHost. À améliorer.

[![Niveau d'intégration](https://dash.yunohost.org/integration/jitsi.svg)](https://dash.yunohost.org/appci/app/jitsi) ![](https://ci-apps.yunohost.org/ci/badges/jitsi.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/jitsi.maintain.svg)  
[![Installer Jitsi Meet avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=jitsi)

*[Read this readme in english.](./README.md)*

> *Ce package vous permet d'installer Jitsi Meet rapidement et simplement sur un serveur YunoHost.  
Si vous n'avez pas YunoHost, consultez [le guide](https://yunohost.org/#/install) pour apprendre comment l'installer.*

## Vue d'ensemble
Jitsi Meet est un logiciel libre (Apache) dont Jitsi Videobridge, avec WebRTC Javascript, propose des vidéos-conférences de haute qualité, sécurisées et évolutives.

**Version actuelle :** 1.0.4127

## Points importants à préparer avant l'installation

1. **Jitsi** a besoin d'un **domaine racine** dédié, par exemple : jitsi.domain.tld
2. **Jitsi** nécessite des domaines supplémentaires au niveau du DNS et de votre YunoHost
  * auth.jitsi.domain.tld
  * conference.jitsi.domain.tld
  * jitsi-videobridge.jitsi.domain.tld
  * focus.jitsi.domain.tld
3. **Jitsi** demande que les ports TCP/4443 et UDP/10000 soient routés vers votre YunoHost (De la même manière que le sont les ports 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)

## Captures d'écran

![](https://jitsi.org/wp-content/uploads/2018/08/brady-bunch-stand-up-1024x632.jpg)

## Démo

* [Démo officielle](https://meet.jit.si/)

## Configuration

Comment configurer cette application: via le panneau d'administration, un fichier brut en SSH ou tout autre moyen.

## Documentation

 * Documentation officielle : https://jitsi.org/user-faq/

## Caractéristiques spécifiques YunoHost

#### Architectures supportées

* x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/jitsi/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/jitsi/)

## Liens

 * Signaler un bug: https://github.com/YunoHost-Apps/jitsi_ynh/issues
 * Site de l'application: https://jitsi.org/
 * Dépôt de l'application principale: https://github.com/jitsi/jitsi-meet
 * Site web YunoHost: https://yunohost.org/

---

Informations pour les développeurs
----------------

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
ou
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```
