#!/bin/bash

level=6
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="DXjZPULLxYr17uwoI01bNLQbtFemEgo7"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "cat \$(find / -size 33c -user bandit7 -group bandit6 2>/dev/null)")
next_bandit_pass=$(echo $next_bandit_pass | cut -d " " -f -1)

echo "Bandit$(($level+1)) Password: $next_bandit_pass"