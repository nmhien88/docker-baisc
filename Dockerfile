FROM debian:stretch-slim

COPY run.sh /bin/run.sh

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends wget curl apt-transport-https lsb-release ca-certificates gnupg xz-utils openssh-client \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list \
    && apt update && apt install -y --no-install-recommends dos2unix git gcc make g++ \
        php5.6-fpm php5.6 libapache2-mod-php5.6 apache2 php5.6-tidy php5.6-imagick php5.6-gd php5.6-gmp php5.6-mysql php5.6-curl php5.6-ldap php5.6-mcrypt php5.6-xdebug php5.6-dom php5.6-mbstring php5.6-xml php5.6-zip php5.6-bz2 \
        ruby-dev rubygems mysql-client locales nodejs libxrender1 xvfb xauth fontconfig xfonts-base xfonts-75dpi \
    && wget https://github.com/jwilder/dockerize/releases/download/v0.6.0/dockerize-linux-amd64-v0.6.0.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.0.tar.gz \
    && rm dockerize-linux-amd64-v0.6.0.tar.gz \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb && rm wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && gem update --system --no-document && gem install bundler \
    && npm install -g npm@latest \
    && npm install -g yarn \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
    && rm composer-setup.php \
    && sed -i 's/^# *\(fr_FR.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(en_GB.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(de_DE.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(es_ES.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
    && mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh \
    && ssh-keyscan github.com > /root/.ssh/known_hosts \
    && a2enmod headers \
    && a2enmod rewrite \
    && dos2unix /bin/run.sh \
    && apt-get remove -y gcc make g++ dos2unix \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/www/project

ENV APACHE_RUN_SERVER www-data \
    APACHE_RUN_GROUP www-data \
    ENV APACHE_LOG_DIR /var/log/apache2 \
    ENV APACHE_LOCK_DIR /var/lock/apache2 \
    ENV APACHE_PID_FILE /var/run/apache2.pid

COPY pool.conf /etc/php/5.6/fpm/pool.d/www.conf
COPY php-fpm.conf /etc/php/5.6/fpm/php-fpm.conf
COPY php.ini /etc/php/5.6/fpm/php.ini
RUN cp /etc/php/5.6/fpm/php.ini /etc/php/5.6/cli/php.ini && cp /etc/php/5.6/fpm/php.ini /etc/php/5.6/apache2/php.ini
COPY apache_config.conf /etc/apache2/sites-enabled/000-default.conf
COPY xdebug.ini /etc/php/5.6/apache2/conf.d/xdebug.ini


# generate project path
WORKDIR /var/www/project

CMD ["/bin/run.sh"]
