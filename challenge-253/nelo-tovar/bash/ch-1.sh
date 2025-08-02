#!/usr/bin/env bash 
#
# The Weekly Challenge 253 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/
#
# Task 1 : Split Strings

function split_strings() {
    local separator=${!1}
    local words=(${!2})
    local split=()

    IFS=$separator
    for i in ${words[@]}; do
        if [[ -n "$i" ]]; then
            split+=($i)
        fi
    done

    echo ${split[@]} 
}


example1='one.two.three four.five six'
separator1='.'
example2='$perl$$ $$raku$'
separator2='$'

for e in 1 2; do
    v_w="example$e"
    v_s="separator$e"

    ss=($(split_strings $v_s $v_w))
    echo "Input  : words = (${!v_w})"
    echo "         separator = ${!v_s}"
    echo "Output : (${ss[@]})"
    echo ""
done

