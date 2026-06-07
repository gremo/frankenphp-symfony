<!-- markdownlint-disable MD033 -->
# FrankenPHP Symfony

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/gremo/frankenphp-symfony/.github/workflows/ci.yaml?label=CI&style=flat-square)](https://github.com/gremo/frankenphp-symfony/actions/workflows/ci.yaml)
[![GitHub last commit](https://img.shields.io/github/last-commit/gremo/frankenphp-symfony?style=flat-square)](https://github.com/gremo/frankenphp-symfony/commits/main)
[![GitHub issues](https://img.shields.io/github/issues/gremo/frankenphp-symfony?style=flat-square)](https://github.com/gremo/frankenphp-symfony/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/gremo/frankenphp-symfony?style=flat-square)](https://github.com/gremo/frankenphp-symfony/pulls)
[![DockerHub](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/r/gremo/frankenphp-symfony)

[FrankenPHP](https://frankenphp.dev/) docker images optimized for [Symfony](https://symfony.com/) framework 7/8, available in **Alpine** and **Debian** variants (amd64 and arm64). Images created every monday, after daily FrankenPHP release.

## 💫 Key features

- ✅ Ships with [Composer](https://getcomposer.org) and commonly used PHP extensions
- ✅ Performance-oriented and [recommended PHP settings](https://symfony.com/doc/current/performance.html#use-the-opcache-class-preloading)
- ✅ Supervisor for long-running [Messenger workers](https://symfony.com/doc/current/messenger.html#messenger-supervisor)
- ✅ Configuration and OS utilites for [Asset Mapper precompression](https://symfony.com/doc/current/frontend/asset_mapper.html#performance-precompressing)
- ✅ Quick default-site customization without full Caddyfile override

## 🚀 Quick start

Want to give it a try? Download the [example Dev Container](https://github.com/gremo/frankenphp-symfony/releases/download/latest/devcontainer-image.zip), open the project in Visual Studio Code and install Symfony:

```bash
curl -O https://raw.githubusercontent.com/symfony/skeleton/refs/heads/8.1/composer.json
composer install
```

Your project is ready at [localhost](https://localhost) 💪

## 🛠️ What's included

<details>
  <summary>View <b>OS packages</b> available</summary>
  <p dir="auto"></p>

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/packages.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->
</details>

<details>
  <summary>View <b>PHP extensions</b> available</summary>
  <p dir="auto"></p>

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php-extensions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->
</details>

<details>
  <summary>View <b>PHP configuration</b> details</summary>
  <p dir="auto"></p>

<b>All</b> environments:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<b>Development</b> environment:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php-dev.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<b>Production</b> environment:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./docs/php-prod.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->
</details>

## ❤️ Contributing

All types of contributions are encouraged and valued. See the [contributing](.github/CONTRIBUTING.md) guidelines, the community looks forward to your contributions!

## 📘 License

Released under the terms of the [ISC License](LICENSE).
