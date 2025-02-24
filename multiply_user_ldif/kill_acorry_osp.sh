#!/bin/bash

cd /home/edir/ldif

ice -S LDIF -f kill_acorry_osp.ldif -D LDAP -s magilla -d cn=admin,ou=sa,o=system -w noguessing
