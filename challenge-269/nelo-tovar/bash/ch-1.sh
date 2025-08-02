#!/usr/bin/env bash 
#
# The Weekly Challenge 269 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/
#
# Task 1 : Bitwise OR

function bitwise_or() {
    local nums=("$@")
    local length=${#nums[@]}

    for (( i = 0; i < $length - 1; i++ )); do
        for (( j = $i + 1 ; j < $length; j++ )); do
            k=$(( ${nums[$i]} | ${nums[$j]} ))
            if [[ $(($k % 2)) -eq 0 ]]; then
                echo true
                exit 0
            fi
        done
    done

    echo false
}

examples=('1 2 3 4 5' '2 3 8 16' '1 2 5 7 9')

for e in ${!examples[@]}; do
    array=(${examples[$e]})
    bo=($(bitwise_or "${array[@]}"))
    echo "Input  : inst = (${array[@]})"
    echo "Output : $bo"
    echo ""
done

