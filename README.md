<!-- markdownlint-disable MD033 -->
# FrankenPHP Symfony

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/gremo/frankenphp-symfony/.github/workflows/release.yaml?label=CI&style=flat-square)](https://github.com/gremo/frankenphp-symfony/actions/workflows/release.yaml)
[![GitHub last commit](https://img.shields.io/github/last-commit/gremo/frankenphp-symfony?style=flat-square)](https://github.com/gremo/frankenphp-symfony/commits/main)
[![GitHub issues](https://img.shields.io/github/issues/gremo/frankenphp-symfony?style=flat-square)](https://github.com/gremo/frankenphp-symfony/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/gremo/frankenphp-symfony?style=flat-square)](https://github.com/gremo/frankenphp-symfony/pulls)
[![DockerHub](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/r/gremo/frankenphp-symfony)

[FrankenPHP](https://frankenphp.dev/) docker images optimized for [Symfony](https://symfony.com/) framework, available in **Alpine** and **Debian** variants.

> [!NOTE]
> Alpine is often avoided because it uses musl instead of glibc, which can cause compatibility issues with precompiled binaries and some PHP extensions compared to Debian-based images.

## 💫 Key features

- ✅ Smooth integration with the VS Code [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- ✅ Ships with [Composer](https://getcomposer.org) and commonly used PHP extensions
- ✅ Performance-oriented and [recommended PHP settings](https://symfony.com/doc/current/performance.html#use-the-opcache-class-preloading)
- ✅ OS utilites for [Asset Mapper precompression](https://symfony.com/doc/current/frontend/asset_mapper.html#performance-precompressing)
- ✅ Supervisor for long-running [Messenger workers](https://symfony.com/doc/current/messenger.html#messenger-supervisor)

## 🚀 Quick start

Want to give it a try? Start a minimal VS Code Dev Container using this `devcontainer.json` placed inside the `.devcontainer` folder:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=./examples/vscode-container.json) -->
<!-- The below code snippet is automatically added from ./examples/vscode-container.json -->
```json
{
  "name": "${localWorkspaceFolderBasename}",
  "image": "gremo/frankenphp-symfony:8.5-alpine-dev",
  "workspaceMount": "source=${localWorkspaceFolder},target=/app,type=bind",
  "workspaceFolder": "/app",
  "mounts": [
    "source=var,target=${containerWorkspaceFolder}/var,type=volume",
    "source=vendor,target=${containerWorkspaceFolder}/vendor,type=volume"
  ],
  "overrideCommand": false,
  "forwardPorts": [80, 443]
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

The install Symfony and open [localhost](https://localhost):

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=./examples/install-symfony.sh) -->
<!-- The below code snippet is automatically added from ./examples/install-symfony.sh -->
```sh
curl -O https://raw.githubusercontent.com/symfony/skeleton/refs/heads/8.1/composer.json
composer install
```
<!-- MARKDOWN-AUTO-DOCS:END -->

## 🛠️ What's included

<details>
  <summary>View <b>OS packages</b> available</summary>
  <p dir="auto"></p>

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/packages.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="package-th">Package</th><th class="environment-th">Environment</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="package-td td_text"><a href="https://github.com/google/brotli">Brotli</a></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Used for Symfony AssetMapper asset pre-compression</td></tr>
<tr ><td class="package-td td_text"><a href="https://supervisord.org">Supervisor</a></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Manages Symfony Messenger worker processes</td></tr>
<tr ><td class="package-td td_text"><a href="https://facebook.github.io/zstd">Zstandard</a></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Used for asset pre-compression in Symfony AssetMapper</td></tr>
<tr ><td class="package-td td_text"><a href="https://git-scm.com">Git</a></td><td class="environment-td td_text"><code>dev</code></td><td class="description-td td_text">Enables Git access with local credentials in Dev Containers</td></tr>
<tr ><td class="package-td td_text"><a href="https://www.gnupg.org">GnuPG</a></td><td class="environment-td td_text"><code>dev</code></td><td class="description-td td_text">Enables GPG commit signing in Dev Containers</td></tr>
<tr ><td class="package-td td_text"><a href="https://www.openssh.org">OpenSSH</a></td><td class="environment-td td_text"><code>dev</code></td><td class="description-td td_text">Enables SSH Git access and deployments from Dev Containers</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
</details>

<details>
  <summary>View <b>PHP extensions</b> available</summary>
  <p dir="auto"></p>

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php-extensions.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="extension-th">Extension</th><th class="name-th">Name</th><th class="environment-th">Environment</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="extension-td td_text"><a href="https://getcomposer.org">Composer</a></td><td class="name-td td_text"><code>@composer</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Manages all Symfony dependencies and package installations</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/book.apcu.php">APCu</a></td><td class="name-td td_text"><code>apcu</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Provides a shared RAM cache for application data, configuration settings, and metadata</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/book.bc.php">BCMath</a></td><td class="name-td td_text"><code>bcmath</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Handles high-precision mathematics for financial calculations and prices</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/book.image.php">GD</a></td><td class="name-td td_text"><code>gd</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Resizes, crops, and optimizes user-uploaded images through media bundles</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/book.intl.php">Intl</a></td><td class="name-td td_text"><code>intl</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Handles international text transliteration, forms localization, and Twig translation formatting</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/ref.pdo-mysql.php">PDO MySQL</a></td><td class="name-td td_text"><code>pdo_mysql</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Connects Doctrine ORM to MySQL databases</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/ref.pdo-pgsql.php">PDO PostgreSQL</a></td><td class="name-td td_text"><code>pdo_pgsql</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Connects Doctrine ORM to PostgreSQL databases</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/book.xsl.php">XSL</a></td><td class="name-td td_text"><code>xsl</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Required by twig/inky-extra to generate responsive HTML email layouts</td></tr>
<tr ><td class="extension-td td_text"><a href="https://www.php.net/manual/en/book.zip.php">Zip</a></td><td class="name-td td_text"><code>zip</code></td><td class="environment-td td_text"><code>all</code></td><td class="description-td td_text">Speeds up Composer downloads and manages zip archives within the application</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
</details>

<details>
  <summary>View <b>PHP configuration</b> details</summary>
  <p dir="auto"></p>

<b>All</b> environments:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="setting-th">Setting</th><th class="value-th">Value</th></tr></thead><tbody ><tr ><td class="setting-td td_text"><code>apc.enable_cli</code></td><td class="value-td td_text"><code>1</code></td></tr>
<tr ><td class="setting-td td_text"><code>memory_limit</code></td><td class="value-td td_text"><code>512M</code></td></tr>
<tr ><td class="setting-td td_text"><code>opcache.interned_strings_buffer</code></td><td class="value-td td_text"><code>32</code></td></tr>
<tr ><td class="setting-td td_text"><code>opcache.max_accelerated_files</code></td><td class="value-td td_text"><code>32531</code></td></tr>
<tr ><td class="setting-td td_text"><code>opcache.memory_consumption</code></td><td class="value-td td_text"><code>256</code></td></tr>
<tr ><td class="setting-td td_text"><code>realpath_cache_ttl</code></td><td class="value-td td_text"><code>600</code></td></tr>
<tr ><td class="setting-td td_text"><code>session.use_strict_mode</code></td><td class="value-td td_text"><code>1</code></td></tr>
<tr ><td class="setting-td td_text"><code>zend.detect_unicode</code></td><td class="value-td td_text"><code>0</code></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<b>Development</b> environment:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php-dev.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="setting-th">Setting</th><th class="value-th">Value</th></tr></thead><tbody ><tr ><td class="setting-td td_text"><code>xdebug.client_host</code></td><td class="value-td td_text"><code>host.docker.internal</code></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<b>Production</b> environment:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php-prod.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="setting-th">Setting</th><th class="value-th">Value</th></tr></thead><tbody ><tr ><td class="setting-td td_text"><code>expose_php</code></td><td class="value-td td_text"><code>0</code></td></tr>
<tr ><td class="setting-td td_text"><code>opcache.preload</code></td><td class="value-td td_text"><code>/app/config/preload.php</code></td></tr>
<tr ><td class="setting-td td_text"><code>opcache.preload_user</code></td><td class="value-td td_text"><code>root</code></td></tr>
<tr ><td class="setting-td td_text"><code>opcache.validate_timestamps</code></td><td class="value-td td_text"><code>0</code></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
</details>

## ❤️ Contributing

All types of contributions are encouraged and valued. See the [contributing](.github/CONTRIBUTING.md) guidelines, the community looks forward to your contributions!

## 📘 License

Released under the terms of the [ISC License](LICENSE).
