#!/usr/bin/env bash 
#
# The Weekly Challenge 262 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
#
# Task 2 : Count Equal Divisible

function count_equal_divisible() {
    local k=$1
    shift
    local nums=("$@")
    local len=${#nums[@]}
    local count=0

    for (( i = 0; i <= $len-1 ; i++ )); do
        for (( j = $i+1; j < $len; j++ )); do
            if [[ (${nums[$i]} -eq ${nums[$j]}) && $(($i * $j % $k)) -eq 0 ]]; then
                ((count++))
            fi
        done
    done

    echo $count
}

example_ints=('3 1 2 2 2 1 3' '1 2 3')
example_k=(2 1)

for e in 0 1; do
    array=(${example_ints[$e]})
    k=${example_k[$e]}
    ced=$(count_equal_divisible $k "${array[@]}")
    echo "Input  : ints = (${array[@]}), and K = $k"
    echo -e "Output : $ced\n"
done

