FROM wwright/magento2-web-local

MAINTAINER Will Wright <will@magesmith.com>

# disable interactive functions
ARG DEBIAN_FRONTEND=noninteractive

#
#   Inject config files at the end to optimize build cache
#
COPY dev/magento /var/www/html/current

RUN chown -R builder:www-data /var/www/html/current && chmod -R g+rw /var/www/html/current

WORKDIR /var/www/html/current