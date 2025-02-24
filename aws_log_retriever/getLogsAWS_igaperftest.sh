#!/bin/bash
echo `date +%s%3N` > /home/time
TIME=$(cat /home/time)
echo $TIME

truncate pod_names1.txt --size 0
truncate pod_name.txt --size 0
truncate getLogsAutoNew.sh --size 0

# grab the names for the pods and write to temp file pod_names1
kubectl get pods -n applications -o json | jq '.items[].metadata | .name' | grep igaperftest > pod_names1.txt

#clean the double quotes from list
sed 's/\"//g' pod_names1.txt > pod_names.txt

file="pod_names.txt"

echo -n "Enter date of the log you want.(Year-Month-Day) Example: "2021-09-27" : "
read my_var

echo "starting"

IFS=$'\n' read -d '' -r -a lines < pod_names.txt

printf "kubectl cp  applications/"${lines[0]}":/usr/share/tomcat/logs/catalina.$my_var.log /home/aws_files/catalina.$my_var#1_$TIME.log --no-preserve=true" >> getLogsAutoNew.sh
echo >> getLogsAutoNew.sh
printf "kubectl cp  applications/"${lines[1]}":/usr/share/tomcat/logs/catalina.$my_var.log /home/aws_files/catalina.$my_var#2_$TIME.log --no-preserve=true" >> getLogsAutoNew.sh
echo >> getLogsAutoNew.sh
printf "kubectl cp  applications/"${lines[2]}":/usr/share/tomcat/logs/catalina.$my_var.log /home/aws_files/catalina.$my_var#3_$TIME.log --no-preserve=true" >> getLogsAutoNew.sh

chmod 777 getLogsAutoNew.sh

./getLogsAutoNew.sh

