#!/bin/bash

###########################################################################
# script name: ch46-2.bash                                                #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/         #
#                                                                         #
###########################################################################

declare -a doors
readonly MAX=500
returnString=""

function change () {
    returnString="CLOSED"
    if [ "$1" == "CLOSED" ] ; then
        returnString="OPENED"
    fi
}

for ((h=1; h <= MAX; h++ ))
do
    doors[$h]="CLOSED"
done

for ((i=1; i <= MAX; i++ ))
do
    if [ $i -gt $((MAX / 2)) ]; then
        change "${doors[$i]}"
        doors[$i]="$returnString"
        continue
    fi

    for ((j=1; j <= MAX; j++ ))
    do
        if [ $((j % i)) == 0 ]; then
            change "${doors[$j]}"
            doors[$j]="$returnString"
        fi
    done
done

for ((k=1; k <= MAX; k++ ))
do
    if [ "${doors[$k]}" == "OPENED" ]; then
        printf "%s " $k
    fi
done
echo 

# ch-2.bash output:
#                    1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484
