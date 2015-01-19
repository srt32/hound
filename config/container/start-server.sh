#!/bin/bash

cd /hound
source /etc/profile.d/rvm.sh
bundle exec unicorn -D -p 8080 -c ./config/unicorn.rb
nginx
