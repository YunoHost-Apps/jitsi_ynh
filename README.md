# Jitsi Meet for YunoHost

[![Integration level](https://dash.yunohost.org/integration/jitsi.svg)](https://dash.yunohost.org/appci/app/jitsi)  
[![Install Jitsi Meet with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=jitsi)

> *This package allow you to install Jitsi Meet quickly and simply on a YunoHost server.  
[Install YunoHost](https://yunohost.org/#/install) to be able to do so.*

## Overview
Jitsi Meet is a libre software (Apache) WebRTC JavaScript app that uses Jitsi Videobridge to provide high quality, secure, and scalable video conferences.

**Shipped version:** 1.0.3729

## Important points before installing

1. **Jitsi** requires a dedicated **root domain**, eg. jitsi.domain.tld
2. **Jitsi** requires you create additionals domains in your DNS and in your YunoHost
  * auth.jitsi.domain.tld
  * conference.jitsi.domain.tld
  * coturn.jitsi.domain.tld
  * focus.jitsi.domain.tld
  * jitsi-videobridge.jitsi.domain.tld
3. **Jitsi** requires the ports TCP/5349 UDP/5349 TCP/5350 UDP/5350 TCP/4443 and UDP/10000 to be forwarded to your YunoHost (The same way you forwarded 80 (HTTP), 443 (HTTPS), etc... https://yunohost.org/#/isp_box_config)
4. **Jitsi** for YunoHost for now as some limitations:
  * Can only be used using Chrome/Chromium
  * Is limited to two participants

## Screenshots

![](https://jitsi.org/wp-content/uploads/2018/08/brady-bunch-stand-up-1024x632.jpg)

## Demo

* [Official demo](https://meet.jit.si/)

## Configuration

How to configure this app: Via the admin panel, a plain file with SSH, or any other way.

## Documentation

 * Official documentation: https://jitsi.org/user-faq/

## Specific YunoHost features

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/jitsi/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/jitsi/)

## Links

 * Report a bug: https://github.com/YunoHost-Apps/jitsi_ynh/issues
 * App website: https://jitsi.org/
 * Upstream app repository: https://github.com/jitsi/jitsi-meet
 * YunoHost website: https://yunohost.org/

---

Developer info
----------------

Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
or
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```
