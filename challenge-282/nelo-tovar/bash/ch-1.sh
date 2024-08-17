#!/usr/bin/env bash 
#
# The Weekly Challenge 282 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
#
# Task 1 : Good Integer

function good_integer() {
    local nums=$1
    local match=$(grep -oP '([0-9])\1{2,}' <<< "$nums")

    if [[ ${#match} == 3 ]]; then
        echo $match 
    else
        echo -1
    fi
}

examples=(12344456 1233334 10020003)

for e in ${examples[@]}; do
    gi=($(good_integer "$e"))
    echo "Input  : nums = $e"
    echo "Output : $gi"
    echo ""
done

