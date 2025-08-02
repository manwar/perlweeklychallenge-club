#!/usr/bin/env bash 
#
# The Weekly Challenge 252 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/
#
# Task 1 : Special Numbers

function special_numbers() {
    local ints=("$@")
    local n=${#ints[@]}
    local sum=0

    for x in ${ints[@]}; do
        if [[ $(($n % $x)) -eq 0 ]]; then
            ((sum+=$(($x ** 2))))
        fi
    done

    echo $sum
}

example1='1 2 3 4'
example2='2 7 1 19 18 3'

for e in "$example1" "$example2" ; do
    array=($e)
    sn=$(special_numbers "${array[@]}")
    echo "Input  : @ints = (${array[@]})"
    echo "Output : $sn"
    echo ""
done

