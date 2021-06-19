#!/bin/bash

level=22
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI"

command="cat /tmp/\$(echo I am user bandit23 | md5sum | cut -d ' ' -f 1)"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"