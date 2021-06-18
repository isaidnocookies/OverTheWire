#!/bin/bash

level=13
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL"

sshpass -p "$bandit_pass" scp -P 2220 $bandit_user@$bandit_host:/home/$bandit_user/sshkey.private ./temp/temp.privatekey
chmod 600 ./temp/temp.privatekey

level=14
bandit_user="bandit$level"
command="cat /etc/bandit_pass/$bandit_user | nc localhost 30000"
next_bandit_pass=$(ssh -i ./temp/temp.privatekey $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"