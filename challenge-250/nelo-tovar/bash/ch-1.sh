#!/usr/bin/env bash 
#
# The Weekly Challenge 250 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/
#
# Task 1 : Smallest Index

function smallest_index() {
    local ints=("$@")
    local length=${#ints[@]}

    for (( i = 0; i < $length; i++ )); do
        if [[ $(($i % 10)) -eq ${ints[$i]} ]]; then
            echo $i
            return 0
        fi
    done

    echo -1
}

example1='0 1 2'
example2='4 3 2 1'
example3='1 2 3 4 5 6 7 8 9 0'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    si=$(smallest_index "${array[@]}")
    echo "Input  : @ints = (${array[@]})"
    echo "Output : $si"
    echo ""
done

