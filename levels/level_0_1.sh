#!/bin/bash

bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit0"
bandit0_pass="bandit0"

bandit1_pass=$(sshpass -p "$bandit0_pass" ssh $bandit_user@$bandit_host -p 2220 cat readme)
bandit1_pass=$(echo $bandit1_pass | cut -d " " -f -1)

echo "Bandit1 Password: $bandit1_pass"