#!/opt/homebrew/bin/bash

function ord {
    printf "%d" "'$1"
}

while read line
do
    f1=$(ord ${line:0:1})
    r1=$(ord ${line:1:1})
    f2=$(ord ${line:3:1})
    r2=$(ord ${line:4:1})
    res=$(( (((f1 % 2 == r1 % 2) ? 1 : 0) + \
             ((f2 % 2 == r2 % 2) ? 1 : 0)) ))
    if   [[ $res -eq 1 ]]
    then echo false
    else echo true
    fi

done
