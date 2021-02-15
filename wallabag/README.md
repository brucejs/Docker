# brucejs/wallabag

Custom PHP image based upon [php:7.3-fpm](https://hub.docker.com/_/php) for running [Wallabag v2.3.8](https://github.com/wallabag/wallabag/tree/2.3.8).

## Required PHP modules:

Wallabag v2.3.8 requires the following [PHP modules](https://doc.wallabag.org/en/admin/installation/requirements.html#php-extensions). Checked items are already provided by php:7.3-fpm:

- [ ] `bcmath`
- [x] `ctype`
- [x] `curl`
- [x] `dom`
- [x] `fpm`
- [ ] `gd`
- [ ] `gettext`
- [x] `hash`
- [x] `iconv`
- [ ] `intl`
- [x] `json`
- [x] `mbstring`
- [ ] `pdo_mysql`
- [ ] `pdo_pgsql`
- [x] `pdo_sqlite`
- [x] `session`
- [ ] `sockets`
- [x] `simplexml`
- [ ] `tidy`
- [x] `tokenizer`
- [x] `xml`
