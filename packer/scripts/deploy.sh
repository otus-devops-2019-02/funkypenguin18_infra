#!/bin/bash

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d

#Is service started, on port 9292?
pu=$(ps aux | grep puma | grep 9292)

if [[ "$pu" == *"reddit"* ]]
then
echo "Puma deployed and started"
else
echo "Something goes wrong"
fi
