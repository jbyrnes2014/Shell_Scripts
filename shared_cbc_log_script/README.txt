1. copy getLogsAWS_CBC.sh, getLogsAutoNew.sh, pod_names1.txt and pod_name.txt to a dir.
2. Create a folder to output to, you can change the output but this is where its going to dump the log: /home/aws_files
3. In k92 you need to authenticate to AWS. eval "$(pass aws-sts-env-vars)" and assume_iam_role.
4. Run this getLogsAWS_CBC.sh

It gathers the Pod name, cleans the output and then generates a scrip with the pod name and copies the log file from Shared CBC down.

The script creates a scipt with the updated CBC pod name and then runs.

kubectl cp  bridge/bridge-client-7bcd9f9f66-rjzzm:/bridge_client.log /home/aws_files/catalina.2022-08-17#1_1660754960278.log --no-preserve=true

/home/aws_files/catalina.2022-08-17#1_1660754960278.log

test test test