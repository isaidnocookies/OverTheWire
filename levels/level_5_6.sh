#!/bin/bash

level=5
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="koReBOKuIDDepwhWk7jZC0RTdopnAYKh"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "cat \$(find ./inhere/ -size 1033c ! -executable) | cut -d ' ' -f 1 | head -n 1")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"