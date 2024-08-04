#!/usr/bin/env bash 
#
# The Weekly Challenge 280 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/
#
# Task 1 - Twice Appearance

function twice_appearance() {
    local string=$1
    local length=${#string}
    declare -A temp

    for (( i = 0; i < $length; i++ )); do
        letter=${string:$i:1}
        if [[ -n "${temp[$letter]}" ]]; then
            echo $letter
            break
        fi
        temp[$letter]=1
    done

    echo ' '
}

examples=("acbddbca" "abccd" "abcdabbb")

for e in ${examples[@]}; do
    ta=$(twice_appearance "$e")
    echo "Input  : str = $e"
    echo "Output : $ta"
done

