#!/usr/bin/env bash 
#
# The Weekly Challenge 281 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-281/
#
# Task 1 - Check Color

function check_color() {
    local coordinates=$1

    if [[ $coordinates =~ [aceg][1357] ]]; then
        echo 'false'
    else
        echo 'true'
    fi
}

examples=('d3' 'g5' 'e6')

for e in ${examples[@]}; do
    array=($e)
    cc=($(check_color $e))
    echo "Input  : coordinates = $e"
    echo "Output : $cc"
    echo ""
done

