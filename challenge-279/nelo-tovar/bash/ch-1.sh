#!/usr/bin/env bash 
#
# The Weekly Challenge 279 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
#
# Task 1 - Sort Letters

function sort_letters() {
    local letters=($1)
    local weights=($2)
    local word=''
    declare -A temp

    for i in "${!letters[@]}"; do
        temp[${weights[$i]}]=${letters[$i]}
    done

    for key in $(echo ${weights[@]} | tr " " "\n" | sort -n); do
        word+=${temp[$key]}
    done

    echo $word
}

example_letters=('R E P L' 'A U R K' 'O H Y N P T')
example_weights=('3 2 1 4' '2 4 1 3' '5 4 2 6 1 3')

for e in ${!example_letters[@]}; do
    sl=($(sort_letters "${example_letters[$e]}" "${example_weights[$e]}"))
    echo "Input  : letters = (${example_letters[$e]})"
    echo "         weights = (${example_weights[$e]})"
    echo "Output : $sl"
    echo ""
done

