#!/bin/bash

level=12
bandit_host="bandit.labs.overthewire.org"
bandit_user="bandit$level"
bandit_pass="5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu"
tDir="/tmp/myboopingdir"

# Make tmp dir
next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "mkdir $tDir")

# Push helper script to box
sshpass -p "$bandit_pass" scp -P 2220 ./helpers/decompressor.sh $bandit_user@$bandit_host:$tDir/decompressor.sh

command="cp \$(ls) $tDir/data.txt; cat $tDir/data.txt | xxd -r > $tDir/data; rm $tDir/data.txt; chmod +x $tDir/decompressor.sh; cd $tDir; ./decompressor.sh; cat \$(ls data*);"
next_bandit_pass=$(sshpass -p "$bandit_pass" ssh $bandit_user@$bandit_host -p 2220 "$command")
next_bandit_pass=$(echo $next_bandit_pass | awk '{print $NF}')

echo "Bandit$(($level+1)) Password: $next_bandit_pass"