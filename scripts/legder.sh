#!/bin/bash

cd /app
#screen -dmS FAIL make BOLOS_ENV=~/bolos-devenv BOLOS_SDK=~/bolos-devenv/nanos-secure-sdk load
while true
do
    sleep 0.2
    if screen -ls | grep -q "FAIL"; then
        echo "first make still running, waiting for end"
    else
        echo "Starting second make"
        make BOLOS_ENV=~/bolos-devenv BOLOS_SDK=~/bolos-devenv/nanos-secure-sdk load
        exit
    fi
done