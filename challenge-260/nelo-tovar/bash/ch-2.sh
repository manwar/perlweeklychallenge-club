#!/usr/bin/env bash 
#
# The Weekly Challenge 260 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
#
# Task 2 : Dictionary Rank

function swap() {
    local string=$1
    local len=${#string}
    local from=$2
    local to=$3
    local i=0
    local s=""
    while [[ $i -lt $len ]]; do
        if [[ $i -eq $from ]]; then
            s=$s${string:$to:1}
        elif [[ $i -eq $to ]]; then
            s=$s${string:$from:1}
        else
            s=$s${string:$i:1}
        fi
        i=$(($i+1))
    done
    echo $s
}
 
function perm() {
    local string=$1
    local len=${#string}
    local idx=$2
    if [[ $idx -ge $len ]]; then
        echo $string
    else
        local i=$idx
        while [[ $i -lt $len ]]; do
            perm $(swap $string $i $idx) $((idx+1))
            i=$((i+1))
        done
    fi
}

function dictionary_rank() {
    local word=$1
    local rank=0
    local dictionary=($(perm $word | sort))

    for i in "${!dictionary[@]}"; do
        if [[ "$word" = "${dictionary[$i]}" ]]; then
            rank=$(($i + 1))
            break
        fi
    done

    echo $rank
}

example1='CAT GOOGLE SECRET'

for e in $example1; do
    dr=$(dictionary_rank "$e")
    echo "Input  : word = ($e)"
    echo -e "Output : $dr\n"
done

