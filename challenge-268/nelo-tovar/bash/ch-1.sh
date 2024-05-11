#!/usr/bin/env bash 
#
# The Weekly Challenge 268 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
#
# Task 1 : Magic Number

function magic_number() {
    local x=($1)
    local y=($2)
    IFS=$'\n' xx=($(sort -n <<<"${x[*]}"))
    IFS=$'\n' yy=($(sort -n <<<"${y[*]}"))
    unset IFS

    b=$((${xx[0]}-${yy[0]}))

    echo ${b#-}
}

examples_x=('3 7 5' '1 2 1' '2')
examples_y=('9 5 7' '5 4 4' '5')

for e in ${!examples_x[@]}; do
    x=${examples_x[$e]}
    y=${examples_y[$e]}
    mn=$(magic_number "$x" "$y")
    echo "Input  : x = ($x)"
    echo "         y = ($y)"
    echo "Output : ($mn)"
    echo ""
done

