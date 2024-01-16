#!/usr/bin/env bash 
#
# The Weekly Challenge 248 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
#
# Task 1 : Shortes Distance

function shortes_distance() {
#    local nums=("$@")
#    local length=${#nums[@]}
    local str=$1
    local length=${#str}
    local chr=$2
    local indexes=()
    local distances=()

    for (( i = 0; i < $length; i++ )); do
        if [[ ${str:$i:1} == $chr ]]; then
            indexes+=($i)
        fi
    done
    for (( i = 0; i < $length; i++ )); do
        min=$length

        for j in ${indexes[@]}; do
            d=$(($j - $i))
            d=${d#-}

            if [[ $d -lt $min ]]; then
                min=$d
            fi
        done

        distances+=($min)
    done

    echo ${distances[@]} 
}

example_str_1='loveleetcode'
example_str_2='aaab'
example_chr_1='e'
example_chr_2='b'

for e in 1 2; do
    str="example_str_$e"
    chr="example_chr_$e"
    sd=($(shortes_distance ${!str} ${!chr}))
    echo "Input  : str = ${!str}, char = ${!chr}"
    echo "Output : (${sd[@]})"
    echo ""
done

