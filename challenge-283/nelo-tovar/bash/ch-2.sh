#!/usr/bin/env bash 
#
# The Weekly Challenge 283 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
#
# Task 2 - Digit Count Value

function frequency() {
    local array=("$@")
    declare -A local frequency

    for i in ${array[@]}; do
        temp=${frequency[$i]}
        ((temp++))
        frequency[$i]=$temp
    done

    echo "${frequency[@]@K}"
}

function digit_count_value() {
    local nums=("$@")
    declare -A frequencies="($(frequency "${nums[@]}"))"

    for i in ${!nums[@]}; do
        if [[ ${frequencies[$i]} -ne ${nums[$i]} ]]; then
            echo 'false'
            exit
        fi
    done

    echo 'true'
}

examples=('1 2 1 0' '0 3 0')

for e in "${examples[@]}"; do
    array=($e)
    dcv=$(digit_count_value "${array[@]}")
    echo "Input  : ints = (${array[@]})"
    echo -e "Output : $dcv\n"
done

