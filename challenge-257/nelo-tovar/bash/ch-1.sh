#!/usr/bin/env bash 
#
# The Weekly Challenge 257 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/
#
# Task 1 : Smaller than Current

function smaller_than_current() {
    local ints=("$@")
    local length=${#ints[@]}
    local smallers=()

    for i in ${ints[@]}; do
        count=0
        for j in ${ints[@]}; do
            if [ $j -lt $i ]; then
                ((count++))
            fi
        done
        smallers+=($count)
    done
    echo ${smallers[@]} 
}

example1='5 2 1 6'
example2='1 2 0 3'
example3='0 1'
example4='9 4 9 2'

for e in "$example1" "$example2" "$example3" "$example4"; do
    array=($e)
    stc=($(smaller_than_current "${array[@]}"))
    echo "Input  : nums = (${array[@]})"
    echo "Output : (${stc[@]})"
    echo ""
done

