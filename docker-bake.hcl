# Bake is an abstraction over the Docker build command that simplifies the management of build configurations,
# including CLI flags, environment variables, and other settings. In this project, the Bake file also acts as
# the single source of truth for metadata, such as PHP versions and extensions, which is parsed to generate
# the documentation.

# Base image name used for tagging and publishing.
IMAGE_NAME = "gremo/frankenphp-symfony"

# Target environments used to control build variations and runtime behavior.
ENVIRONMENTS = ["dev", "prod"]

# FrankenPHP version used as base runtime for all images.
FRANKENPHP_VERSION = "1.12"

# Operating systems included in the build matrix.
OS_PLATFORMS = ["alpine", "trixie"]

# List of OS packages installed in the image, including purpose, environment scope, and documentation links.
# Packages are enabled based on the target environment (e.g. "all", "dev", or "prod").
OS_PACKAGES = [
  {
    "name": "Brotli",
    "url": "https://github.com/google/brotli",
    "why": "Used for Symfony AssetMapper asset pre-compression",
    "env": "all",
    "packages": {
      "alpine": "brotli",
      "trixie": "brotli"
    }
  },
  {
    "name": "Supervisor",
    "url": "https://supervisord.org",
    "why": "Manages Symfony Messenger worker processes",
    "env": "all",
    "packages": {
      "alpine": "supervisor",
      "trixie": "supervisor"
    }
  },
  {
    "name": "Zstandard",
    "url": "https://facebook.github.io/zstd",
    "why": "Used for asset pre-compression in Symfony AssetMapper",
    "env": "all",
    "packages": {
      "alpine": "zstd",
      "trixie": "zstd"
    }
  },
  {
    "name": "Git",
    "url": "https://git-scm.com",
    "why": "Enables Git access with local credentials in Dev Containers",
    "env": "dev",
    "packages": {
      "alpine": "git",
      "trixie": "git"
    }
  },
  {
    "name": "GnuPG",
    "url": "https://www.gnupg.org",
    "why": "Enables GPG commit signing in Dev Containers",
    "env": "dev",
    "packages": {
      "alpine": "gnupg",
      "trixie": "gnupg2"
    }
  },
  {
    "name": "OpenSSH",
    "url": "https://www.openssh.org",
    "why": "Enables SSH Git access and deployments from Dev Containers",
    "env": "dev",
    "packages": {
      "alpine": "openssh-client",
      "trixie": "openssh-client"
    }
  }
]

# PHP versions included in the build matrix.
# Each version is built across multiple OS and environments.
PHP_VERSIONS = [ "8.5", "8.4", "8.3", "8.2" ]

# List of PHP extensions installed in the image, including purpose, environment scope, and documentation links.
# Extensions are enabled based on the target environment (e.g. "all", "dev", or "prod").
PHP_EXTENSIONS = [
  {
    "name": "Composer",
    "why": "Manages all Symfony dependencies and package installations",
    "env": "all",
    "package": "@composer",
    "url": "https://getcomposer.org"
  },
  {
    "name": "APCu",
    "why": "Provides a shared RAM cache for application data, configuration settings, and metadata",
    "env": "all",
    "package": "apcu",
    "url": "https://www.php.net/manual/en/book.apcu.php"
  },
  {
    "name": "BCMath",
    "why": "Handles high-precision mathematics for financial calculations and prices",
    "env": "all",
    "package": "bcmath",
    "url": "https://www.php.net/manual/en/book.bc.php"
  },
  {
    "name": "GD",
    "why": "Resizes, crops, and optimizes user-uploaded images through media bundles",
    "env": "all",
    "package": "gd",
    "url": "https://www.php.net/manual/en/book.image.php"
  },
  {
    "name": "Intl",
    "why": "Handles international text transliteration, forms localization, and Twig translation formatting",
    "env": "all",
    "package": "intl",
    "url": "https://www.php.net/manual/en/book.intl.php"
  },
  {
    "name": "PDO MySQL",
    "why": "Connects Doctrine ORM to MySQL databases",
    "env": "all",
    "package": "pdo_mysql",
    "url": "https://www.php.net/manual/en/ref.pdo-mysql.php"
  },
  {
    "name": "PDO PostgreSQL",
    "why": "Connects Doctrine ORM to PostgreSQL databases",
    "env": "all",
    "package": "pdo_pgsql",
    "url": "https://www.php.net/manual/en/ref.pdo-pgsql.php"
  },
  {
    "name": "XSL",
    "why": "Required by twig/inky-extra to generate responsive HTML email layouts",
    "env": "all",
    "package": "xsl",
    "url": "https://www.php.net/manual/en/book.xsl.php"
  },
  {
    "name": "Zip",
    "why": "Speeds up Composer downloads and manages zip archives within the application",
    "env": "all",
    "package": "zip",
    "url": "https://www.php.net/manual/en/book.zip.php"
  }
]

# Target used to build images for structural and smoke testing.
# To keep builds fast, images are built only for the default linux/amd64 platform.
target "test" {
  name = "test-php-${replace(php, ".", "")}-${os}-${env}"
  matrix = {
    "php" = PHP_VERSIONS,
    "os" = OS_PLATFORMS,
    "env" = ENVIRONMENTS,
  }

  dockerfile = "Dockerfile.${os}"
  args = {
      # Build arguments for the Dockerfile
      FRANKENPHP_VERSION = FRANKENPHP_VERSION
      PACKAGES_BASE = join(" ", [ for p in OS_PACKAGES : p.packages[os] if p.env == "all" ])
      PACKAGES_ENV = join(" ", [ for p in OS_PACKAGES : p.packages[os] if p.env == env ])
      PHP_VERSION = php
      EXTENSIONS_BASE = join(" ", [ for v in PHP_EXTENSIONS : v.package if v.env == "all" ])
      EXTENSIONS_ENV = join(" ", [ for v in PHP_EXTENSIONS : v.package if v.env == env ])

      # These args are added solely because, during matrix generation in a GitHub Action, the only available value is
      # the target, but parsing the target (to extract PHP, OS, or ENV) would be unreliable.
      OS = os
      ENV = env
  }
  target = env

  tags = [
    "${IMAGE_NAME}:test-${php}-${os}-${env}",
  ]

  cache-from = ["type=gha,scope=build-${php}-${os}-${env}"]
  cache-to = ["type=gha,mode=max,scope=build-${php}-${os}-${env}"]
}

# Target used to build images for release and publishing to Docker Hub.
target "release" {
  name = "php-${replace(php, ".", "")}-${os}-${env}"
  matrix = {
    "php" = PHP_VERSIONS,
    "os" = OS_PLATFORMS,
    "env" = ENVIRONMENTS,
  }

  dockerfile = "Dockerfile.${os}"
  args = {
      # Build arguments for the Dockerfile
      FRANKENPHP_VERSION = FRANKENPHP_VERSION
      PACKAGES_BASE = join(" ", [ for p in OS_PACKAGES : p.packages[os] if p.env == "all" ])
      PACKAGES_ENV = join(" ", [ for p in OS_PACKAGES : p.packages[os] if p.env == env ])
      PHP_VERSION = php
      EXTENSIONS_BASE = join(" ", [ for v in PHP_EXTENSIONS : v.package if v.env == "all" ])
      EXTENSIONS_ENV = join(" ", [ for v in PHP_EXTENSIONS : v.package if v.env == env ])
  }
  target = env
  platforms = ["linux/amd64", "linux/arm64"]

  tags = compact([
    "${IMAGE_NAME}:${php}-${os}-${env}",
    os == "trixie" ? "${IMAGE_NAME}:${php}${env == "dev" ? "-dev" : ""}" : null,
    env == "prod" ? "${IMAGE_NAME}:${php}-${os}" : null,
    env == "prod" && os == "trixie" ? "${IMAGE_NAME}:${php}" : null,
  ])

  labels = {
    "org.opencontainers.image.title" = "FrankenPHP Symfony"
    "org.opencontainers.image.description" = "FrankenPHP docker image optimized for Symfony"
    "org.opencontainers.image.licenses" = "ISC"
    "org.opencontainers.image.source" = "https://github.com/${IMAGE_NAME}"
    "org.opencontainers.image.url" = "https://github.com/${IMAGE_NAME}"
    "org.opencontainers.image.vendor" = split("/", IMAGE_NAME)[0]
    "frankenphp.version" = FRANKENPHP_VERSION
    "org.opencontainers.image.version" = "${php}-${os}-${env}"
    "org.opencontainers.image.created" = timestamp()
  }

  cache-from = ["type=gha,scope=build-${php}-${os}-${env}"]
  cache-to = ["type=gha,mode=max,scope=build-${php}-${os}-${env}"]
}
