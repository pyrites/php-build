FROM       centos:6
MAINTAINER Yosuke Yamamoto "yosuke@pyrites.jp"

## Setting Args
#
ARG PHP_VERSION=5.6.25
ARG PHP_BUILD_DIR=/usr/local/src/php-build
ARG PHP_INST_PATH=/usr/local

## To see a list of all available PHP versions, run php-build --definitions.
RUN yum -y install epel-release && \
    yum -y update && \
    yum -y install git gcc make openssl-devel curl-devel readline-devel libmcrypt-devel \
                   libxml2-devel libjpeg-devel libpng-devel libXpm-devel freetype-devel \
                   libmcrypt-devel libtidy-devel libxslt-devel && \
    yum -y install httpd httpd-devel && \
    git clone git://github.com/php-build/php-build.git $PHP_BUILD_DIR && \
    $PHP_BUILD_DIR/install.sh && rm -Rf $PHP_BUILD_DIR && \
    CONFIGURE_OPTS="--with-apxs2" php-build $PHP_VERSION $PHP_INST_PATH && \
    curl -sS https://getcomposer.org/installer | php && mv -f composer.phar $PHP_INST_PATH/bin/composer && \
    yum -y remove epel-release && \
    yum -y remove openssl-devel curl-devel readline-devel libmcrypt-devel libxml2-devel libjpeg-devel \
                  libpng-devel libXpm-devel freetype-devel libmcrypt-devel libtidy-devel libxslt-devel && \
    yum clean all && \
    rm -Rf /tmp/*

#EXPOSE 80/tcp
#VOLUME [/var/www]
#ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

