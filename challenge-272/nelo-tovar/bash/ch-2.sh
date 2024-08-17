#!/usr/bin/env bash 
#
# The Weekly Challenge 272 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
#
# Task 2 : String Score

function ord() {
        LC_CTYPE=C printf '%d' "'$1"
}

function string_score() {
    local str=$1
    local len=$((${#str}-1))
    local sum=0

    for (( i = 0; i < $len; i++ )); do
        c1=$(ord "${str:i:1}")
        c2=$(ord "${str:i+1:1}")
        diff=$((c1-c2))
        ((sum+=${diff#-}))
    done

    echo $sum
}

examples=('hello' 'perl' 'raku')

for e in ${examples[@]}; do
    ss=$(string_score "$e")
    echo "Input  : str = $e"
    echo -e "Output : $ss\n"
done

