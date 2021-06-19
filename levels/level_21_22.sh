#!/bin/bash

level=21
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr"

command="cat \$(cat \$(cat /etc/cron.d/cronjob_bandit22 | head -n 1 | cut -d ' ' -f 3) | tail -n -1 | awk '{print \$NF}')"

next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"