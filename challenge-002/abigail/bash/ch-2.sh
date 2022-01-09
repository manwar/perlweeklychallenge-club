#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

printf -v ord_0 %d "'0"
printf -v ord_A %d "'A"

while getopts "ft" opt
do  case "${opt}" in
        f) action=from ;;
        t) action=to   ;;
    esac
done

function from_base_35 () {
    local in=$1
    local ord
    local char
    base_10=0

    for ((i = 0; i < ${#in}; i ++))
    do  ((base_10 = 35 * base_10))
        char=${in:$i:1}
        printf -v ord %d "'$char"
        if [[ $char =~ [0-9] ]]
        then ((base_10 = base_10 + ord - ord_0))
        else ((base_10 = base_10 + ord - ord_A + 10))
        fi
    done
}

function to_base_35 () {
    local in=$1
    base_35=""

    while ((in > 0))
    do  ((rem = in % 35))
        ((in  = in / 35))
        if ((rem > 9))
        then printf -v char "\x$(printf %x $((ord_A + rem - 10)))"
        else char=$rem
        fi
        base_35=${char}${base_35}
    done
}

while read line
do   if [[ "$action" = from ]]
     then from_base_35 $line; echo $base_10
     else to_base_35   $line; echo $base_35
     fi
done
