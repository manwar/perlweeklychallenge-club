#!/usr/bin/env bash 
#
# The Weekly Challenge 263 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/
#
# Task 1 : Target Index

function target_index() {
    local k=$1
    shift
    local nums=("$@")
    local length=${#nums[@]}
    local indexes=()

    nums=($(IFS=$'\n'; echo "${nums[*]}" | sort -n))

    for (( i = 0; i < $length; i++ )); do
        if [[ ${nums[$i]} -eq $k ]]; then
            indexes+=($i)
        fi
    done

    echo ${indexes[@]} 
}

examples_ints=('1 5 3 2 4 2' '1 2 4 3 5' '5 3 2 4 2 1')
examples_k=(2 6 4)

for e in 0 1 2; do
    array=(${examples_ints[$e]})
    k=${examples_k[$e]}
    ti=($(target_index $k "${array[@]}"))
    echo "Input  : ints = (${array[@]}), K = $k"
    echo "Output : (${ti[@]})"
    echo ""
done

