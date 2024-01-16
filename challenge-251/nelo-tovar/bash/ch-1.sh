#!/usr/bin/env bash 
#
# The Weekly Challenge 251 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-251/
#
# Task 1 : Concatenation Value

function concatenation_value() {
    local ints=("$@")
    local length=${#ints[@]}
    local value=''

    while [[ $length > 0 ]]; do
        first=${ints[0]}
        if [[ $length -gt 1 ]]; then
            last=${ints[-1]}
        else
            last=''
        fi

        value=$(( $value + ${first}${last} ))

        unset ints[-1]
        ints=("${ints[@]:1}")
        length=${#ints[@]}
    done

    echo $value 
}

example1='6 12 25 1'
example2='10 7 31 5 2 2'
example3='1 2 10'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    cv=$(concatenation_value "${array[@]}")
    echo "Input  : ints = (${array[@]})"
    echo "Output : $cv"
    echo ""
done

