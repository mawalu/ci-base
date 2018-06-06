#!/bin/sh

apt-get update
apt-get install -y gnupg

# install node.js and yarn
curl -sL https://deb.nodesource.com/setup_8.x | bash -

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install dependencies
apt-get update && apt-get upgrade -y
apt-get install -y git openssh-client zip curl libpng-dev libgd-dev nodejs xvfb yarn netcat libnss3 libgconf-2-4 wget zlib1g-dev libicu-dev g++ libpq-dev libxml2-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev libwebp-dev libxpm-dev
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install quasar cli
yarn global add quasar-cli

# chrome dev
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
apt-get update && apt-get install -y google-chrome-unstable

# set memory limit
echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# install php extensions
docker-php-ext-configure intl
docker-php-ext-install pdo_mysql zip intl pdo_pgsql soap xml gd

pecl install xdebug > /dev/null
docker-php-ext-enable xdebug
