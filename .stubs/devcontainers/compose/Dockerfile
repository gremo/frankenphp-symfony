ARG PHP_VERSION

FROM gremo/frankenphp-symfony:${PHP_VERSION}-dev AS dev
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

FROM gremo/frankenphp-symfony:${PHP_VERSION} AS prod
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

COPY --link config/docker/site.caddyfile /etc/frankenphp/site.d/site.caddyfile
COPY --link config/docker/php.ini $PHP_INI_DIR/conf.d/20-php.ini
COPY --link config/docker/php.prod.ini $PHP_INI_DIR/conf.d/30-php.ini
COPY --link composer.* symfony.* ./

RUN composer install --no-cache --prefer-dist --no-dev --no-autoloader --no-scripts --no-progress

COPY --link . /app

RUN \
    mkdir -p var/cache var/log; \
    chmod +x bin/console; \
    composer dump-autoload --classmap-authoritative --no-dev; \
    composer dump-env prod; \
    bin/console cache:clear; \
    bin/console assets:install; \
    sync
