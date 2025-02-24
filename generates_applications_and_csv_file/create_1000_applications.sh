#!/bin/bash

mkdir csv
mkdir apps

for i in {1..1}

do

echo `date +%s%3N` > /home/time
TIME=$(cat /home/time)
echo $TIME

echo '{"arraySize":0}' > apps/App"$TIME"Join.json &&

	value=`cat AppOut2.json`
       	echo $value > apps/App$TIME.json &&
sed -i 's@CHANGEIT@'$TIME'@g' apps/App$TIME.json

	value2=`cat PERMISSION.csv`
	echo $value2 > csv/PERMISSION_$TIME.csv &&
sed -i 's@CHANGEIT@'$TIME'@g' csv/PERMISSION_$TIME.csv

	value3=`cat ACCOUNT.csv`
        echo $value3 > csv/ACCOUNT_$TIME.csv &&
sed -i 's@CHANGEIT@'$TIME'@g' csv/ACCOUNT_$TIME.csv

done
