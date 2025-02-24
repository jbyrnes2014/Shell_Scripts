#!/bin/bash

mkdir -p csv
mkdir -p apps

set -e

echo -n "enter the number of files to generate : "
read my_var

for ((n=0;n<$my_var;n++));do	

echo `date +%s%3N` > /home/time
TIME=$(cat /home/time)
echo $TIME


echo '{"arraySize":0}' > apps/App"$TIME"Join.json &&

        value=`cat AppOut2.json`
        echo $value > apps/App$TIME.json &&
sed -i 's@CHANGEIT@'$TIME'@g' apps/App$TIME.json

	value2=$(<PERMISSION.csv)
        echo "$value2" > csv/PERMISSION_$TIME.csv &&
sed -i 's@CHANGEIT@'$TIME'@g' csv/PERMISSION_$TIME.csv

        value3=`cat ACCOUNT.csv`
        echo "$value3" > csv/ACCOUNT_$TIME.csv &&
sed -i 's@CHANGEIT@'$TIME'@g' csv/ACCOUNT_$TIME.csv

done


