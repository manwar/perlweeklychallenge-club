#!/usr/bin/env bash 
#
# The Weekly Challenge 256 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
#
# Task 1 : Maximum Pairs

function maximum_pairs() {
    local words=("$@")
    local length=${#words[@]}
    local max=0

    for (( i = 0; i < $length; i++ )); do
        for (( j = $i + 1 ; j < $length; j++ )); do
            reverse=$(echo ${words[$j]} | rev)
            if [[ ${words[$i]} == $reverse ]]; then
                ((max++))
                break
            fi
        done
    done

    echo $max 
}

example1='ab de ed bc'
example2='aa ba cd ed'
example3='uv qp st vu mn pq'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    mp=($(maximum_pairs "${array[@]}"))
    echo "Input  : words = (${array[@]})"
    echo "Output : $mp"
    echo ""
done

