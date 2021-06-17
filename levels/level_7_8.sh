#!/bin/bash

level=7
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "cat data.txt | grep millionth | cut -d\$'\t' -f 2")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"