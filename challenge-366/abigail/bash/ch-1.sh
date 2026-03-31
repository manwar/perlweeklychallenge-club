#!/opt/homebrew/bin/bash

while read -a words
do  ((valid = 0))
    for i in "${!words[@]}"
    do  prefix=${words[$i]}
        if   [[ $i == 0 ]]
        then target=$prefix
        elif [[ $target =~ ^$prefix ]]
        then (( valid ++ ))
        elif [[ $prefix == '""' ]]
        then (( valid ++ ))
        fi
    done
    echo $valid
done
