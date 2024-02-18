#!/usr/bin/env bash 
#
# The Weekly Challenge 255 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
#
# Task 1 : Odd Character

function odd_character() {
    local s=$1
    local t=$2
    declare -A frequency=()

    for (( i = 0; i < ${#t}; i++ )); do
        letter=${t:$i:1}
        ((frequency[$letter]++))
    done

    for (( i = 0; i < ${#s}; i++ )); do
        letter=${s:$i:1}
        ((frequency[$letter]--))
    done

    for key in "${!frequency[@]}"; do
        if [ ${frequency[$key]} -gt 0 ]; then
            echo $key
            return
        fi
    done

    echo ' '
}


declare -A examples=([Perl]=Preel [Weekly]=Weealy [Box]=Boxy)

for key in "${!examples[@]}"; do
    s=$key
    t=${examples[$key]}
    oc=$(odd_character $s $t)
    echo "Input  : s = $s t = $t"
    echo "Output : $oc"
    echo ""
done

