#!/bin/bash

#Simple script that takes text file in as a template to create
#multiple scripts.

exec &> output.log

for n in $(cat users.csv)
do

    first=$(echo $n | cut -d "," -f 1)

    echo $first

    value=`cat users_script.txt`
    echo "$value" > 'kill_user.sh' &&

    sed -i 's@CHANGE_NAME@'$first'@g' "kill_user.sh"

    cat "kill_user.sh" > "kill_$first.sh"

     
done

