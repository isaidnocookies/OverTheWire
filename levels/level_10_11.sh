#!/bin/bash

level=10
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk"

command="cat \$(ls) | base64 -d | awk '{print \$(NF)}'"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"