FROM classcat/ubuntu-supervisord3:vivid
MAINTAINER ClassCat Co.,Ltd. <support@classcat.com>

########################################################################
# ClassCat/OwnCloud Dockerfile
#   Maintained by ClassCat Co.,Ltd ( http://www.classcat.com/ )
########################################################################

#--- HISTORY -----------------------------------------------------------
#-----------------------------------------------------------------------


#RUN apt-get update && apt-get install -y mysql-client

#WORKDIR /usr/local
#RUN apt-get update && apt-get install -y pwgen

WORKDIR /opt
COPY assets/cc-init.sh /opt/cc-init.sh

EXPOSE 22 443

CMD /opt/cc-init.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
