#!/bin/bash

level=16
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="cluFn7wTiGryunymYOu4RcffSxQluehd"
tDir="/tmp/myotherboop"

command="mkdir $tDir || :; PORT=\$(nmap -sV -p 31000-32000 localhost | grep 'ssl/unknown' | cut -d ' ' -f 1 | cut -d '/' -f 1); echo '$bandit_pass' | openssl s_client -connect localhost:\$PORT -ign_eof | sed -n '/Correct!/,\$p' | sed -n '1!p' | head -n -2 > $tDir/nextKey.pem"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
sshpass -p "$bandit_pass" scp -P 2220 $bandit_user@$bandit_host:$tDir/nextKey.pem ./temp/temp.privatekey

echo "Bandit$(($level+1)) KEY FILE: ./temp/temp.privatekey"