#!/bin/bash

# This scrip will add users to groups in ILM. It used this script + a python script to load in.

exec &> output.log
set +e

[ -e add_users.json ] && rm -- add_users.json

echo `date -d " +MINUTES min" "+%s%3N"` > /home/time
DATE=$(cat /home/time)
echo $TIME

for n in $(cat csv/ilm_users_and_groups_1814.csv)
do

#FirstName LastName title mail employeeType homePhone telephoneNumber mobile uid middle
    first=$(echo "$n" | cut -d "," -f 1)
    second=$(echo $n | cut -d "," -f 2)
    third=$(echo $n | cut -d "," -f 3)
    fourth=$(echo $n | cut -d "," -f 4)
    fifth=$(echo $n | cut -d "," -f 5)

# For troubleshooting
    echo $first >> out.txt
    echo $second >> out.txt
    echo $third  >> out.txt
    echo $fourth >> out.txt
    echo $fifth >> out.txt

    value=`cat add_user_to_group.json`
    echo $value > add_users.json &&

    sed -i 's@CHANGE_GIVENNAME@'$first'@g' "add_users.json"
    sed -i 's@CHANGE_ID@'$second'@g' "add_users.json"
    sed -i 's@CHANGE_USER2@'$third'@g' "add_users.json"
    sed -i 's@CHANGE_UNIQUE@'$fourth'@g' "add_users.json"

    python addUsersToGroups_ilm3.py http://ilm_host.com:9888 tenant password $fifth

#    sleep 1

echo "ILM Group ID:" $fifth
echo "User #1 added:" $first
echo "User #2 added:" $third

j=0

j=$((i++))

echo "Number of Groups Updated:" $j

echo " "
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"

done
