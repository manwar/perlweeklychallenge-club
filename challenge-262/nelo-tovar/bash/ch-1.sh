#!/usr/bin/env bash 
#
# The Weekly Challenge 262 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
#
# Task 1 : Max Positive Negative

function max_positive_negative() {
    local nums=("$@")
    local positive=0
    local negative=0

    for i in "${nums[@]}"; do
        if [ $i -ge 0 ]; then
           ((positive++)) 
        else
            ((negative++))
        fi
    done

    if [ $positive -gt $negative ]; then
        echo $positive
    else
        echo $negative
    fi
}

example1='-3 1 2 -1 3 -2 4'
example2='-1 -2 -3 1'
example3='1 2'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    mpn=($(max_positive_negative "${array[@]}"))
    echo "Input  : ints = (${array[@]})"
    echo "Output : $mpn"
    echo ""
done

