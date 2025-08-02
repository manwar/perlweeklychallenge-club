#!/usr/bin/env bash 
#
# The Weekly Challenge 273 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/
#
# Task 2 : B After A

function b_after_a() {
    local str=$1

    if [[ "$str" =~ bb|^b+$ ]]; then
        echo 'true'
    else
        echo 'false'
    fi
}

examples=('aabb' 'abab' 'aaa' 'bbb')

for e in ${examples[@]}; do
    baa=$(b_after_a "$e")
    echo "Input  : str = $e"
    echo -e "Output : $baa\n"
done

