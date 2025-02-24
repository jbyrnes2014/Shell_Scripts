I needed a way to create individule .ldif files and also a script that would run those .ldif files.

1. create_users_kill_list.sh this creates an ldif for each user in the users.csv file. 

2. create_kill_users_scripts.sh this creates an script for each user. 

I needed a way to clear the osp data from these accounts. This was becuase running access_rquests from the same user list will make it so the accounts get locked.