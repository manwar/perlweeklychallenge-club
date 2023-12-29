#!/usr/bin/env bash 
#
# The Weekly Challenge 249 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
#
# Task 1 : Equal Pairs

function equal_pairs() {
    local numbers=("$@")
    local pairs=()

    while [[ ${numbers[@]} > 0 ]]; do
        number=${numbers[0]}
        numbers=("${numbers[@]:1}")
        length=${#numbers[@]}

        for (( i = 0; i < $length; i++ )); do
             if [[ $number == ${numbers[$i]} ]]; then
                 pairs+=("($number, $number)")
                 unset numbers[$i]
                 break
             fi
        done
    done

    echo ${pairs[@]} 
}

example1='3 2 3 2 2 2'
example2='1 2 3 4'

for e in "$example1" "$example2"; do
    array=($e)
    ep=($(equal_pairs "${array[@]}"))
    echo "Input  : @ints = (${array[@]})"
    echo "Output : (${ep[@]})"
    echo ""
done

