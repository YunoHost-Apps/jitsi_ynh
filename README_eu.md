<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Jitsi Meet YunoHost-erako

[![Integrazio maila](https://apps.yunohost.org/badge/integration/jitsi)](https://ci-apps.yunohost.org/ci/apps/jitsi/)
![Funtzionamendu egoera](https://apps.yunohost.org/badge/state/jitsi)
![Mantentze egoera](https://apps.yunohost.org/badge/maintained/jitsi)

[![Instalatu Jitsi Meet YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jitsi)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Jitsi Meet YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

Jitsi Meet is a libre software (Apache) WebRTC JavaScript app that uses Jitsi Videobridge to provide high quality, secure, and scalable video conferences.


**Paketatutako bertsioa:** 2.0.10078~ynh1

**Demoa:** <https://meet.jit.si/>

## Pantaila-argazkiak

![Jitsi Meet(r)en pantaila-argazkia](./doc/screenshots/screenshot.png)

## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://jitsi.org/>
- Erabiltzaileen dokumentazio ofiziala: <https://jitsi.org/user-faq/>
- Jatorrizko aplikazioaren kode-gordailua: <https://github.com/jitsi/jitsi-meet>
- YunoHost Denda: <https://apps.yunohost.org/app/jitsi>
- Eman errore baten berri: <https://github.com/YunoHost-Apps/jitsi_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request`a [`testing` abarrera](https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing).

`testing` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
edo
sudo yunohost app upgrade jitsi -u https://github.com/YunoHost-Apps/jitsi_ynh/tree/testing --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>
