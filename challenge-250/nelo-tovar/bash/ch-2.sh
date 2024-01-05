#!/usr/bin/env bash 
#
# The Weekly Challenge 250 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/
#
# Task 2 : Alphanumeric String Value

function alphanumeric_string_value() {
    local alphanumstr=("$@")
    local max=0

    for x in ${alphanumstr[@]}; do
        if [[ $x =~ ^[0-9]+$ ]]; then
            value=$((x + 0 ))
        else
           value=${#x}   
        fi

        if [[ $value -gt $max ]]; then
            max=$value
        fi
    done 

    echo $max
}

example1='perl 2 000 python r4ku'
example2='001 1 000 0001' 

for e in "$example1" "$example2"; do
    array=($e)
    asv=$(alphanumeric_string_value "${array[@]}")
    echo "Input  : alphanumstr = (${array[@]})"
    echo -e "Output : $asv\n"
done

