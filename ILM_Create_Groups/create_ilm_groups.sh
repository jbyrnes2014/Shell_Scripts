#!/bin/bash

# This scrip will create Groups in ILM. It used this script + a python script to load in.

exec &> output.log
set +e

[ -e group_data.json ] && rm -- group_data.json

echo `date -d " +MINUTES min" "+%s%3N"` > /home/time
DATE=$(cat /home/time)
echo $TIME

for n in $(cat csv/500.csv)
do

#FirstName LastName title mail employeeType homePhone telephoneNumber mobile uid middle
#    first=$(echo "$n" | cut -d "," -f 1)
    first=$(echo "$n")
 #   second=$(echo $n | cut -d "," -f 2)
#    third=$(echo $n | cut -d "," -f 3)
#    fourth=$(echo $n | cut -d "," -f 4)
#    fifth=$(echo $n | cut -d "," -f 5)
#    sixth=$(echo $n | cut -d "," -f 6)
#    seventh=$(echo $n | cut -d "," -f 7)
#    eight=$(echo $n | cut -d "," -f 8)
#    nine=$(echo $n | cut -d "," -f 9)

# For troubleshooting

    echo "$first" >> out.txt
#    echo $second >> out.txt
#    echo $third  >> out.txt
#    echo $fourth >> out.txt
#    echo $fifth >> out.txt
#    echo $sixth >> out.txt
#    echo $seventh >> out.txt
#    echo $eight >> out.txt
#    echo $nine >> out.txt

     value=`cat group_data_temp.json`
    echo $value > group_data.json &&

    sed -i 's@CHANGE_GIVENNAME@'$first'@g' "group_data.json"
#    sed -i 's@CHANGE_FAMILY@'$second'@g' "user_data.json"
#    sed -i 's@CHANGE_TITLE@'$third'@g' "user_data.json"
#    sed -i 's/CHANGE_EMAIL/'$fourth'/g' "user_data.json"
#    sed -i 's@CHANGE_TYPE@'$fifth'@g' "user_data.json"
#    sed -i 's@CHANGE_NUMBER@'$sixth'@g' "user_data.json"
#    sed -i 's@CHANGE_NAME@'$eight'@g' "user_data.json"
#    sed -i 's@CHANGE_MIDDLE@'$nine'@g' "user_data.json"

    python creatGroups_ilm.py http://ilm_server:9888 tenant password

#    sleep 1

done
