#!/usr/bin/env bash 
#
# The Weekly Challenge 265 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/
#
# Task 1 : 33% Appearance

function _33_percent_appearence() {
    local nums=("$@")
    local length=${#nums[@]}
    local percent=$((($length * 33 + 100 -1) / 100))
    local frequencies
    local candidates

    for i in "${nums[@]}"; do
        ((frequencies[$i]++))
    done

    for key in ${!frequencies[@]}; do
        if [[ ${frequencies[$key]} -ge $percent ]]; then
            candidates+=($key)
        fi
    done

    candidates=($(IFS=$'\n'; echo "${candidates[*]}" | sort -n))

    echo ${candidates[0]} 
}

examples=('1 2 3 3 3 3 4 2' '1 1' '1 2 3')

for e in ${!examples[@]}; do
    array=(${examples[$e]})
    pa=$(_33_percent_appearence "${array[@]}")
    echo "Input  : inst = (${array[@]})"
    echo "Output : $pa"
    echo ""
done

