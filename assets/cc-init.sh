#!/bin/bash

########################################################################
# ClassCat/OwnCloud Asset files
# Copyright (C) 2015 ClassCat Co.,Ltd. All rights reserved.
########################################################################

#--- HISTORY -----------------------------------------------------------
#-----------------------------------------------------------------------


######################
### INITIALIZATION ###
######################

function init () {
  echo "ClassCat Info >> initialization code for ClassCat/OwnCloud"
  echo "Copyright (C) 2015 ClassCat Co.,Ltd. All rights reserved."
  echo ""
}


############
### SSHD ###
############

function change_root_password() {
  if [ -z "${ROOT_PASSWORD}" ]; then
    echo "ClassCat Warning >> No ROOT_PASSWORD specified."
  else
    echo -e "root:${ROOT_PASSWORD}" | chpasswd
    # echo -e "${password}\n${password}" | passwd root
  fi
}


function put_public_key() {
  if [ -z "$SSH_PUBLIC_KEY" ]; then
    echo "ClassCat Warning >> No SSH_PUBLIC_KEY specified."
  else
    mkdir -p /root/.ssh
    chmod 0700 /root/.ssh
    echo "${SSH_PUBLIC_KEY}" > /root/.ssh/authorized_keys
  fi
}


#############
### MYSQL ###
#############

function config_mysql () {
  echo $MYSQL_ROOT_PASSWORD > /root/mysqlpass

#  mysql -u root -p${MYSQL_ROOT_PASSWORD} -h mysql -e "CREATE DATABASE webmail"
#  mysql -u root -p${MYSQL_ROOT_PASSWORD} -h mysql -e "GRANT ALL PRIVILEGES ON webmail.* TO webmail@'%' IDENTIFIED BY 'ClassCatWebmail'";

#  mysql -u root -p${MYSQL_ROOT_PASSWORD} -h mysql webmail < /usr/local/roundcubemail-1.1.1/SQL/mysql.initial.sql
}


################
### OwnCloud ###
################


##################
### SUPERVISOR ###
##################
# See http://docs.docker.com/articles/using_supervisord/

function proc_supervisor () {
# removed the followings:
#[supervisord]
#nodaemon=true

  cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[program:ssh]
command=/usr/sbin/sshd -D

[program:apache2]
command=/usr/sbin/apache2ctl -D FOREGROUND

[program:rsyslog]
command=/usr/sbin/rsyslogd -n
EOF
}


### ENTRY POINT ###

init 
change_root_password
put_public_key
config_mysql

proc_supervisor

exit 0


### End of Script ###