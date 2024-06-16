#!/usr/bin/env bash 
#
# The Weekly Challenge 273 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/
#
# Task 1 : Percentage of Character

function percentage_of_character() {
    local str=$1
    local char=$2
    local length=${#str}
    local without_char=${str//$char/}
    local len_without_char=${#without_char}
    ((count=length-len_without_char))
    percentage=$(echo "scale=2; 0.05+100*$count/$length" | bc )

    printf '%.0f' $percentage
}

examples_str=('perl' 'java' 'python' 'ada' 'ballerina' 'analitik' )
examples_char=('e' 'a' 'm' 'a' 'l' 'k')

for e in ${!examples_str[@]}; do
    str=${examples_str[$e]}
    char=${examples_char[$e]}
    pof=$(percentage_of_character $str $char)
    echo "Input  : str = $str, chr = $char"
    echo "Output : $pof"
    echo ""
done

