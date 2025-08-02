#!/usr/bin/env bash 
#
# The Weekly Challenge 267 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/
#
# Task 1 : Product Sign

function product_sing() {
    local nums=("$@")
    local product=1
    local sign=0

    for i in ${!nums[@]}; do
        ((product*=${nums[$i]}))
    done

    if [ $product -gt 0 ]; then
        sign=1
    elif [ $product -lt 0 ]; then
        sign=-1
    fi

    echo $sign
}

examples=('-1 -2 -3 -4 3 2 1' '1 2 0 -2 -1' '-1 -1 1 -1 2')

for e in ${!examples[@]}; do
    array=(${examples[$e]})
    ps=($(product_sing "${array[@]}"))
    echo "Input  : ints = (${array[@]})"
    echo "Output : $ps"
    echo ""
done

