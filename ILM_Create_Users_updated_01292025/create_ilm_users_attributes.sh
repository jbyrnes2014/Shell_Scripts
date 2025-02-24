#!/bin/bash

# This scrip will create users in ILM. It used this script + a python script to load in.

exec &> output.log
set +e

[ -e user_data.json ] && rm -- user_data.json

echo `date -d " +MINUTES min" "+%s%3N"` > /home/time
DATE=$(cat /home/time)
echo $DATE

ilm_server_url=$1;
container=$2;
password=$3;

function check_parameter {
  if [ -z "$1" ]; then
    echo "Error: Missing parameter: $2"
    exit 1
  fi
}

check_parameter "$1" "ilm_server_url --Ex: http://test.server.com:9888 THOR test"
check_parameter "$2" "containerID --Ex: THOR"
check_parameter "$3" "password --Ex: test "

#for n in $(cat csv/users_new.csv)
for n in $(cat csv/users_updated_address_state.csv)
do

#FirstName LastName title mail employeeType homePhone telephoneNumber mobile uid middle address state
    first=$(echo "$n" | cut -d "," -f 1)
    second=$(echo $n | cut -d "," -f 2)
    third=$(echo $n | cut -d "," -f 3)
    fourth=$(echo $n | cut -d "," -f 4)
    fifth=$(echo $n | cut -d "," -f 5)
    sixth=$(echo $n | cut -d "," -f 6)
    seventh=$(echo $n | cut -d "," -f 7)
    eight=$(echo $n | cut -d "," -f 8)
    nine=$(echo $n | cut -d "," -f 9)
    ten=$(echo "$n" | cut -d "," -f 10)
    eleven=$(echo $n | cut -d "," -f 11)

# For troubleshooting

#    echo "$first" >> out.txt
#    echo $second >> out.txt
#    echo $third  >> out.txt
#    echo $fourth >> out.txt
#    echo $fifth >> out.txt
#    echo $sixth >> out.txt
#    echo $seventh >> out.txt
#    echo $eight >> out.txt
#    echo $nine >> out.txt
#    echo "$ten" > out.txt
#    echo "$eleven" > out.txt

    value=`cat plain.json`
#    value=`cat user_attributes3.json`
    echo $value > user_data.json &&

    sed -i 's@CHANGE_GIVENNAME@'$first'@g' "user_data.json"
    sed -i 's@CHANGE_FAMILY@'$second'@g' "user_data.json"
    sed -i 's@CHANGE_TITLE@'$third'@g' "user_data.json"
    sed -i 's/CHANGE_EMAIL/'$fourth'/g' "user_data.json"
    sed -i 's@CHANGE_TYPE@'$fifth'@g' "user_data.json"
    sed -i 's@CHANGE_NUMBER@'$sixth'@g' "user_data.json"
    sed -i 's@CHANGE_NAME@'$eight'@g' "user_data.json"
    sed -i 's@CHANGE_MIDDLE@'$nine'@g' "user_data.json"
    sed -i 's/CHANGE_ADDRESS/'$ten'/g' "user_data.json"
    sed -i 's@CHANGE_STATE@'$eleven'@g' "user_data.json"

    python creatUser_ilm_final_09252024.py $ilm_server_url $container $password


echo " "
echo "ilm_server: $ilm_server_url"
#    sleep 1
echo " "
echo "User Id being loaded:" $eight
echo " "
j=0
j=$((i++))
echo "Number of Identities added so far:" $j
echo " "
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"


done
