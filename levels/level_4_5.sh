#!/bin/bash

level=4
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="pIwrPrtPN36QITSp3EQaw936yaFoFgAB"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "cat \$(find ./inhere -exec file {} + | grep ASCII | cut -d ':' -f 1)")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"