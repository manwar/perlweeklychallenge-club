#!/opt/homebrew/bin/bash

while read line
do    eval "echo ${line//\?/\{0,1\}}"
done
