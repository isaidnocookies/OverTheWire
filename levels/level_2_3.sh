#!/bin/bash

level=2
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 cat 'spaces\ in\ this\ filename')
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"