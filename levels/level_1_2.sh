#!/bin/bash

bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit1"
bandit0_pass="boJ9jbbUNNfktd78OOpsqOltutMc3MY1"

bandit1_pass=$(sshpass -p "$bandit0_pass" ssh $bandit_user@$bandit_host -p 2220 cat ./-)
bandit1_pass=$(echo $bandit1_pass | cut -d " " -f -1)

echo "Bandit2 Password: $bandit1_pass"