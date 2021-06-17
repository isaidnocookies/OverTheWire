#!/bin/bash

level=8
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="cvX2JJa4CFALtqS87jk27qwqGhBM9plV"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "awk '{!seen[\$0]++};END{for(i in seen) if(seen[i]==1)print i}' \$(ls)")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"