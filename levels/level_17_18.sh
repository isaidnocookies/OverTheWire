#!/bin/bash

level=17
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_ssh_key="./temp/temp.privatekey"

chmod 600 $bandit_ssh_key

command="diff passwords.{old,new} | grep '\>' | cut -d ' ' -f 2"

next_bandit_pass=$(ssh -i $bandit_ssh_key $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"