#!/bin/bash

TEMP='/tmp/boopbeep23'
PASSFILE='/etc/bandit_pass/bandit24'

if [ ! -d $TEMP ]; then
    mkdir $TEMP
fi

touch $TEMP/23_pass.txt
cat $PASSFILE > $TEMP/23_pass.txt

chmod 777 $TEMP
chmod 666 $TEMP/23_pass.txt