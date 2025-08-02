#!/usr/bin/env bash 
#
# The Weekly Challenge 269 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/
#
# Task 2 : Distribute Elements

function distribute_elements() {
    local nums=("$@")
    local n=${#nums[@]}
    local arr1=()
    local arr2=()

    arr1+=(${nums[0]})
    arr2+=(${nums[1]})

    for (( i = 2; i < n; i++ )); do
        if [ ${arr1[-1]} -gt ${arr2[-1]} ]; then
            arr1+=(${nums[$i]})
        else
            arr2+=(${nums[$i]})
        fi
    done

    echo "${arr1[@]} ${arr2[@]}"
}

examples=('2 1 3 4 5' '3 2 4' '5 4 3 8' )

for e in ${!examples[@]}; do
    array=(${examples[$e]})
    gh=$(distribute_elements "${array[@]}")
    echo "Input  : ints = (${array[@]})"
    echo -e "Output : $gh\n"
done

