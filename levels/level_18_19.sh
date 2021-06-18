#!/bin/bash

level=18
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd"

command="cat readme"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"