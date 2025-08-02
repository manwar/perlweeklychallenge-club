#!/usr/bin/env bash 
#
# The Weekly Challenge 275 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/
#
# Task 2 : Replace Digits

ord() {
    LC_CTYPE=C printf '%d' "'$1"
}

chr() {
  printf \\$(printf '%03o' $1)
}

function replace_digits() {
    local str=$1
    local length=${#str}
    local last_letter=${str:0:1}

    for (( i = 1; i < $length; i++ )); do
        local char=${str:$i:1}
        if [[ $char =~ [0123456789] ]]; then
            ((o=$(ord $last_letter) + $char))
            new_letter=$(chr $o)
            str=${str/$char/$new_letter}
        else
            last_letter=$char
        fi
    done

    echo $str
}

examples=('a1c1e1' 'a1b2c3d4' 'b2b' 'a16z')

for e in ${!examples[@]}; do
    gh=$(replace_digits "${examples[$e]}")
    echo "Input  : str = ${examples[$e]}"
    echo -e "Output : $gh\n"
done

