#!/usr/bin/env bash 
#
# The Weekly Challenge 244 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
#
# Task 1 : Count Smaller

function count_smaller() {
    local nums=("$@")
    local length=${#nums[@]}
    local smallers=()

    for (( i = 0; i < $length; i++ )); do
        count=0
        for (( j = 0 ; j < $length; j++ )); do
            if [[ ${nums[$j]} -lt ${nums[$i]} ]]; then
                ((count++))
            fi
        done
        smallers+=($count)
    done

    echo ${smallers[@]} 
}

example1='8 1 2 2 3'
example2='6 5 4 8'
example3='2 2 2'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    cs=($(count_smaller "${array[@]}"))
    echo "Input  : nums = (${array[@]})"
    echo "Output : (${cs[@]})"
    echo ""
done

