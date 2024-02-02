#!/usr/bin/env bash 
#
# The Weekly Challenge 254 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
#
# Task 2 : Reverse Vowels

function reverse_vowels() {
    local s=$1
    local length=${#s}
    local letters=()
    local vowels=()
    local pattern="[aeiouAEIOU]"

    for (( i = 0; i < $length; i++ )); do
        l=${s:$i:1}

        if [[ "$l" =~ $pattern ]]; then
            vowels+=($l)
        fi
        letters+=($l)
    done

    local last=$((${#vowels[@]} - 1))
    for (( i = 0; i < $length; i++ )); do
        if [[ "${letters[$i]}" =~ $pattern ]]; then
            letters[$i]=${vowels[$last]};
            ((last--))
        fi
    done

    printf "%s" ${letters[@]}
}

example1='Raku Perl Julia Uiua'

for e in $example1; do
    rh=$(reverse_vowels "$e")
    echo "Input  : s = $e"
    echo -e "Output : $rh\n"
done

