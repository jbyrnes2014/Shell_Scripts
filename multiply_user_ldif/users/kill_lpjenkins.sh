#!/bin/bash

cd /home/edir/ldif/users

ice -S LDIF -f kill_lpjenkins.ldif -D LDAP -s magilla -d cn=admin,ou=sa,o=system -w noguessing
