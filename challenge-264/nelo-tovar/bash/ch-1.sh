#!/usr/bin/env bash 
#
# The Weekly Challenge 264 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
#
# Task 1 : Greatest English Letter

function greatest_english_letter() {
    local str=$1
    local len=${#str}
    local greatest=''

    for (( i = 0; i < $len; i++ )); do
        letter=${str:$i:1}

        if [[ $letter == ${letter^^} ]]; then
            lower=${letter,,}

            if [[ $greatest < $letter && $str =~ $lower ]]; then
                greatest=$letter
            fi
        fi
    done

    echo $greatest 
}

examples=('PeRlwEeKLy' 'ChaLlenge' 'the')

for e in ${examples[@]}; do
    gel=$(greatest_english_letter $e)
    echo "Input  : str = $e"
    echo "Output : $gel"
    echo ""
done

