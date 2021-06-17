#!/bin/bash

level=11
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR"

command="cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m' | awk '{print \$(NF)}'"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"