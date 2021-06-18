#!/bin/bash

level=15
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="BfMYroe26WYalil77FoDi9qh59eK5xNr"

command="echo \"$bandit_pass\" | openssl s_client -connect localhost:30001 -ign_eof | tail -n 3 | head -n 1"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"