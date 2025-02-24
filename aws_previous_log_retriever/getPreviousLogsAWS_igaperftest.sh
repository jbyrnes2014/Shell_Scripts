#!/bin/bash
echo `date +%s%3N` > /home/time
TIME=$(cat /home/time)
echo $TIME

kubectx arn:aws:eks:us-east-2:338453893816:cluster/eks-igaperf02-srv-ig

truncate pod_names1.txt --size 0
truncate pod_name.txt --size 0
truncate getPreviousLogsAutoNew.sh --size 0

# grabs the names for the pods and write to temp file pod_names1
kubectl get pods -n applications -o json | jq '.items[].metadata | .name' | grep igaperftest | grep -v amq > pod_names1.txt
#clean the double quotes from list
sed 's/\"//g' pod_names1.txt > pod_names.txt

file="pod_names.txt"

echo -n "Enter date of the log you want.(Year-Month-Day) Example: "2021-09-27" : "
read my_var

	echo "starting"

IFS=$'\n' read -d '' -r -a lines < pod_names.txt

printf "kubectl logs -p pod/"${lines[0]}" -n applications > /home/aws_files/${lines[0]}.$my_var#1_$TIME.log" >> getPreviousLogsAutoNew.sh
echo >> getPreviousLogsAutoNew.sh

printf "kubectl logs -p pod/"${lines[1]}" -n applications > /home/aws_files/${lines[1]}.$my_var#2_$TIME.log" >> getPreviousLogsAutoNew.sh
echo >> getPreviousLogsAutoNew.sh

printf "kubectl logs -p pod/"${lines[2]}" -n applications > /home/aws_files/${lines[2]}.$my_var#3_$TIME.log" >> getPreviousLogsAutoNew.sh
echo >> getPreviousLogsAutoNew.sh

	chmod 777 getPreviousLogsAutoNew.sh

./getPreviousLogsAutoNew.sh

