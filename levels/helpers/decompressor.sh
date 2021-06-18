#!/bin/bash

KEEPGOING=true

while $KEEPGOING
do
    if [ ! -f data ];
    then
        mv $(ls data*) data
    fi

    FILEDATA=$(file data)

    if [[ $FILEDATA == *"ASCII"* ]];
    then
        KEEPGOING=false
    fi

    if [[ $FILEDATA == *"gzip"* ]];
    then
        mv data data.gz && gzip -d data.gz
    fi

    if [[ $FILEDATA == *"bzip2"* ]];
    then
        mv data data.bz && bzip2 -d data.bz
    fi

    if [[ $FILEDATA == *"tar"* ]];
    then
        mv data data.tar && tar -xf data.tar && rm data.tar
    fi
done