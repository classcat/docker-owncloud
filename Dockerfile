FROM classcat/ubuntu-supervisord3:vivid
MAINTAINER ClassCat Co.,Ltd. <support@classcat.com>

########################################################################
# ClassCat/OwnCloud Dockerfile
#   Maintained by ClassCat Co.,Ltd ( http://www.classcat.com/ )
########################################################################

#--- HISTORY -----------------------------------------------------------
# 16-may-15 : owncloud.
#-----------------------------------------------------------------------


#RUN apt-get update && apt-get install -y mysql-client

WORKDIR /usr/local
RUN apt-get update && apt-get install -y bzip2 \
  && wget https://download.owncloud.org/community/owncloud-8.0.2.tar.bz2 \
  && tar xfj owncloud-8.0.2.tar.bz2 \
  && mv /var/www/html /var/www/html.orig \
  && cp -r owncloud /var/www/html \
  && chown -R www-data.www-data /var/www/html/config \
  && chown -R www-data.www-data /var/www/html/apps \
  && a2enmod ssl \
  && a2ensite default-ssl

WORKDIR /opt
COPY assets/cc-init.sh /opt/cc-init.sh

EXPOSE 22 443

CMD /opt/cc-init.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
