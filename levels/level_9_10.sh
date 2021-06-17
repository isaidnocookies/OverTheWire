#!/bin/bash

level=9
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR"

command="strings data.txt | grep '===' | tail -1 | cut -d ' ' -f 2"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"