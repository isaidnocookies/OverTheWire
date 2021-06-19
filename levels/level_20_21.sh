#!/bin/bash

level=20
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="GbKksEFF4yrVs6il55v6gwY5aVje5f0j"

command="nc -nvlp 4444 < /etc/bandit_pass/bandit20 &>/dev/null & (sleep 2; ./\$(ls) 4444)"
bandit_output=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
bandit_output=$(echo $bandit_output | grep "Read" | cut -d ':' -f 2 | xargs | cut -d ' ' -f 1)

echo "Bandit$(($level+1)) Password: $bandit_output"