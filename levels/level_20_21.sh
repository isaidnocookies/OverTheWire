#!/bin/bash

level=20
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="GbKksEFF4yrVs6il55v6gwY5aVje5f0j"

command=""

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"