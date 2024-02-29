#!/usr/bin/env bash 
#
# The Weekly Challenge 258 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
#
# Task 1 : Count Even Digits Number

function count_even_digits_number() {
    local nums=("$@")
    local counter=0

    for i in ${nums[@]}; do
        if [[ $((${#i} % 2)) -eq 0 ]]; then
            ((counter++))
        fi
    done

    echo $counter 
}

example1='10 1 111 24 1000'
example2='111 1 11111'
example3='2 8 1024 256'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    cegn=($(count_even_digits_number "${array[@]}"))
    echo "Input  : ints = (${array[@]})"
    echo "Output : $cegn"
    echo ""
done

