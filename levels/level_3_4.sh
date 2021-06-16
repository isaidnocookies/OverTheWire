#!/bin/bash

level=3
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 cat ./inhere/.hidden)
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"