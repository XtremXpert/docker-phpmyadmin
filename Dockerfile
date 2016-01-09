
FROM alpine:edge

MAINTAINER XtremXpert <xtremxpert@xtremxpert.com>

ENV LANG="fr_CA.UTF-8" \
	LC_ALL="fr_CA.UTF-8" \
	LANGUAGE="fr_CA.UTF-8" \
	TZ="America/Toronto" \
	TERM="xterm"

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz /tmp/
COPY config.inc.php /www/
COPY run.sh /run.sh

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && \
	apk update && \
	apk add \
		ca-certificates \
		mc \
		nano \
		openntpd \
		php-cli \
		php-mysqli \
		php-ctype \
		php-xml \
		php-gd \
		php-zlib \
		php-openssl \
		php-curl \
		php-opcache \
		php-json curl \		
		rsync \
		tar \
		tzdata \
		unzip \
	&& \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	rm -fr /var/lib/apk/* && \
	rm -rf /var/cache/apk/* && 
	curl --location https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz | tar xzf - && \
 	mv phpMyAdmin* /www && \
 	rm -rf /www/js/jquery/src/ /www/examples /www/po/ 

RUN chmod u+rwx /run.sh

RUN sed -i \
		-e "s/^upload_max_filesize\s*=\s*2M/upload_max_filesize = 64M/" \
		-e "s/^post_max_size\s*=\s*8M/post_max_size = 64M/" \
		/etc/php/php.ini

EXPOSE 8080

ENTRYPOINT ["/init"]

CMD [ "/run.sh" ]
