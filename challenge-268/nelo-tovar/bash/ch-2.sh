#!/usr/bin/env bash 
#
# The Weekly Challenge 268 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
#
# Task 2 : Number Game

function number_game() {
    local nums=("$@")
    local len=${#nums[@]}
    local result=()
    IFS=$'\n' xx=($(sort -n <<<"${nums[*]}"))

    for (( i = 0; i < $len; i+=2 )); do
        result+=(${xx[$i+1]} ${xx[$i]})
    done

    echo ${result[@]}
}

examples=('2 5 3 4' '9 4 1 3 6 4 6 1' '1 2 2 3')

for e in "${examples[@]}"; do
    array=($e)
    ng=$(number_game "${array[@]}")
    echo "Input  : nums = (${array[@]})"
    echo -e "Output : $ng\n"
done

