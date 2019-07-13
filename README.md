# Jitsi Meet for YunoHost

[![Integration level](https://dash.yunohost.org/integration/jitsi.svg)](https://dash.yunohost.org/appci/app/jitsi)  
[![Install Jitsi Meet with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=jitsi)

*[Lire ce readme en français.](./README_fr.md)*

> *This package allow you to install Jitsi Meet quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview
Jitsi Meet is an open-source (Apache) WebRTC JavaScript application that uses Jitsi Videobridge to provide high quality, secure and scalable video conferences.

**Shipped version:** 1.0.3775

## Important points to read before installing

1. **Jitsi** require a dedicated **root domain**, eg. jitsi.domain.tld
2. **Jitsi** require your create additionals dns names in your dns that goes to your YunoHost
  * auth.jitsi.domain.tld
  * conference.jitsi.domain.tld
  * jitsi-videobridge.jitsi.domain.tld
  * focus.jitsi.domain.tld
3. **Jitsi** require the ports TCP/4443 and UDP/10000 been redirected to your YunoHost

## Screenshots

![](https://jitsi.org/wp-content/uploads/2018/08/brady-bunch-stand-up-1024x632.jpg)

## Demo

* [Official demo](https://meet.jit.si/)

## Configuration

How to configure this app: by an admin panel, a plain file with SSH, or any other way.

## Documentation

 * Official documentation: https://jitsi.org/user-faq/

## YunoHost specific features

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/jitsi/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/jitsi/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/ci/logs/jitsi%20%28Apps%29.svg)](https://ci-stretch.nohost.me/ci/apps/jitsi/)

## Links

 * Report a bug: https://github.com/YunoHost-Apps/jitsi_ynh/issues
 * App website: https://jitsi.org/
 * Upstream app repository: https://github.com/jitsi/jitsi-meet
 * YunoHost website: https://yunohost.org/

---

Developers info
----------------

Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
or
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```
