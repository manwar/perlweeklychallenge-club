#!/usr/bin/env bash 
#
# The Weekly Challenge 261 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/
#
# Task 1 : Element Digit Sum

function sum0() {
    local number=$1
    local sum=0

    for (( i = 0; i < ${#number}; i++ )); do
        digit=${number:$i:1}
        ((sum+=$digit))
    done

    echo $sum
}

function element_digit_sum() {
    local nums=("$@")
    local length=${#nums[@]}
    local sum=0

    for (( i = 0; i < $length; i++ )); do
        if [[ ${nums[$i]} -gt 9 ]]; then
            d=$(sum0 ${nums[$i]})
            ((sum+=${nums[$i]} - $d))
        fi
    done

    echo ${sum#-} 
}

example1='1 2 3 45'
example2='1 12 3'
example3='1 2 3 4'
example4='236 416 336 350'

for e in "$example1" "$example2" "$example3" "$example4"; do
    array=($e)
    eds=($(element_digit_sum "${array[@]}"))
    echo "Input  : ints = (${array[@]})"
    echo "Output : $eds"
    echo ""
done

