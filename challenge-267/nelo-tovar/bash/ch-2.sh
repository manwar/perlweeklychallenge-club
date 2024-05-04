#!/usr/bin/env bash 
#
# The Weekly Challenge 267 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/
#
# Task 2 : Line Counts

function ord() {
    printf "%d" "'$1"
}

function line_count() {
    local line=$1
    shift
    local width=("$@")
    local len=${#line}
    local width_sum=0
    local line_counter=0
    local ord_a=$(ord 'a')

    for (( i = 0; i < $len; i++ )); do
        ((letter=$(ord ${line:$i:1}) - $ord_a))
        ((b=$width_sum + ${width[$letter]}))

        if [ $b -le 100 ]; then
            ((width_sum+=${width[$letter]}))
        else
            ((line_counter++))
            width_sum=${width[$letter]}
        fi
    done

    if [ $width_sum -gt 0 ]; then
        ((line_counter++))
    fi


    echo "$line_counter, $width_sum"
}

example_lines=("abcdefghijklmnopqrstuvwxyz" "bbbcccdddaaa")
example_widths=(
    '10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10' 
    '4 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10')

for e in ${!example_lines[@]}; do
    line=${example_lines[$e]}
    width=(${example_widths[$e]})
    lc=$(line_count "$line" "${width[@]}")
    echo "Input  : line = $line"
    echo "Input  : width = ${width[@]}"
    echo -e "Output : $lc\n"
done

