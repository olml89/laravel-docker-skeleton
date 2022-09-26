# Pull php-fpm image
FROM php:8.1-fpm-alpine

# Install php extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install xdebug when on debug mode
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
ARG XDEBUG_PORT

RUN if [ "${XDEBUG_PORT}" ] ; then \
    apk --update --no-cache add autoconf g++ make; \
	pecl install xdebug; \
	docker-php-ext-enable xdebug; \
    apk del --purge autoconf g++ make; \
    echo "xdebug.client_port=${XDEBUG_PORT}" >> /usr/local/etc/php/conf.d/xdebug.ini; \
else \
    rm /usr/local/etc/php/conf.d/xdebug.ini; \
fi

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
