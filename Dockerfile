FROM debian
RUN sed -i 's/http:/https:/g' /etc/apt/sources.list.d/debian.sources
RUN echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/99ignore-ssl-certificates

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY app /var/www/html

RUN rm /var/www/html/index.html
RUN chown -R www-data:www-data /var/www/html

COPY apache2.conf /etc/apache2/apache2.conf

RUN a2enmod rewrite

COPY docker-entrypoint.sh /usr/local/
RUN chmod +x /usr/local/docker-entrypoint.sh

EXPOSE 80
ENV MYSQL_USER biblio
ENV MYSQL_PASSWORD biblio
ENV MYSQL_DATABASE biblio
ENV MYSQL_HOST biblio-db
ENV MYSQL_ROOT_PASSWORD root
ENV BASE_URL http://biblio.org/
CMD /usr/local/docker-entrypoint.sh
