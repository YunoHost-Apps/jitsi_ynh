# Jitsi Meet pour YunoHost

## Avertissements

**Jitsi** pour YunoHost est limité actuellement :

  * Il ne peut être utilisé qu'avec Chrome ou un navigateur basé sur Chromium
  * Il est limité à 2 participants par réunion

Ces limitations viennent de la manière dont l'application a été empaquetée pour YunoHost. À améliorer.

[![Integration level](https://dash.yunohost.org/integration/jitsi.svg)](https://dash.yunohost.org/appci/app/jitsi)  
[![Install Jitsi Meet with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=jitsi)

> *Ce paquet vous permet d'installer Jistsi Meet rapidement et simplement sur un serveur YunoHost. 
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Jitsi Meet est un logiciel libre (Apache) dont Jitsi Videobridge, avec WebRTC Javascript, propose des vidéos-conférences de haute qualité, sécurisées et évolutives.

**Version actuelle :** 1.0.3729

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

## Démonstration

* [Démonstration officielle](https://meet.jit.si/)

## Configuration

Comment configurer cette application : Via l'interface d'administration, un fichier texte en SSH ou un autre moyen.

## Documentation

 * Documentation officielle : https://jitsi.org/user-faq/

## Fonctionnalités spécifiques à YunoHost

#### Architectures supportées

* x86-64b - [![Status des compilations](https://ci-apps.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/jitsi/)
* ARMv8-A - [![Status des compilations](https://ci-apps-arm.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/jitsi/)

## Liens

 * Rapporter un bug : https://github.com/YunoHost-Apps/jitsi_ynh/issues
 * Site de l'application : https://jitsi.org/
 * Répertoire de l'application de base : https://github.com/jitsi/jitsi-meet
 * Site web de YunoHost : https://yunohost.org/

---

Informations pour les développeurs 
----------------



Merci de faire votre « pull request » sur la [branche de test](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

Pour tester la branche de test, faites comme ceci.
```
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
or
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```
