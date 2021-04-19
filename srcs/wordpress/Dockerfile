# FROM alpine:3.12

# EXPOSE 5050

# RUN apk add lighttpd

# RUN apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl \
# php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap \
# php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
# RUN apk add wget mysql-client

# RUN cd /var/www/localhost/htdocs ; wget https://ja.wordpress.org/latest-ja.tar.gz ; tar -xzvf latest-ja.tar.gz ; rm latest-ja.tar.gz
# RUN cd / ; chown -R lighttpd /var/www/localhost/htdocs/wordpress

# ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

FROM alpine:latest

COPY srcs/wordpress.tar.gz /tmp/
COPY srcs/setup.sh /tmp/
RUN /tmp/setup.sh && rm /tmp/setup.sh

# RUN echo 'index.html' > /var/www/localhost/htdocs/index.html

EXPOSE 5050

# -D = dont go to background
ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
