#!/usr/bin/env bash 
#
# The Weekly Challenge 282 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
#
# Task 2 : Changing Keys

function changing_keys() {
    local nums=$1
    local temp=${nums,,}
    local length=${#temp}
    declare -A local keys

    for (( i = 0; i < $length; i++ )); do
        local digit=${temp:$i:1}
        keys[$digit]=1
    done

    echo $((${#keys[@]} - 1))
}

examples=('pPeERrLl' 'rRr' 'GoO')

for e in ${examples[@]}; do
    ck=$(changing_keys "$e")
    echo "Input  : str = $e"
    echo -e "Output : $ck\n"
done

