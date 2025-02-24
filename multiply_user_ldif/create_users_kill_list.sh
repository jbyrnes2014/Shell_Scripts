#!/bin/bash

#This script reads a list from a CSV file and then uses that list to place the user names
#into the .ldif file and then also names that .ldif with the user's name as well.

exec &> output.log

for n in $(cat users.csv)
do

    first=$(echo $n | cut -d "," -f 1)

    echo $first

    value=`cat ldif_template.txt`
    echo "$value" > 'kill_user.ldif' &&

    sed -i 's@CHANGE_NAME@'$first'@g' "kill_user.ldif"

    cat "kill_user.ldif" > "kill_$first.ldif"

     
done

