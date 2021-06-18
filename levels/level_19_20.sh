#!/bin/bash

level=19
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x"

command="./bandit20-do cat /etc/bandit_pass/bandit20"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"