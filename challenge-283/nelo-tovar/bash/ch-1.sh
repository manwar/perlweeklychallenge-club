#!/usr/bin/env bash 
#
# The Weekly Challenge 283 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
#
# Task 1 - Unique Number

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

function unique_number() {
    local nums=("$@")
    declare -A frequencies="($(frequency "${nums[@]}"))"

    for key in ${!frequencies[@]}; do
       if [ ${frequencies[$key]} -eq 1 ]; then
           echo $key
           exit 
       fi
    done

    echo ''
}

examples=('3 3 1' '3 2 4 2 4' '1' '4 3 1 1 1 4')

for e in "${examples[@]}"; do
    array=($e)
    un=($(unique_number "${array[@]}"))
    echo "Input  : ints = (${array[@]})"
    echo "Output : $un"
    echo ""
done

