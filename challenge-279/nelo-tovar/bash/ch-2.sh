#!/usr/bin/env bash 
#
# The Weekly Challenge 279 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
#
# Task 2 - Split String

function split_string() {
    local word=$1
    word=${word,}
    local consonants=$(echo $word | tr -d [aeiou])
    ((vowels_count=${#word} - ${#consonants}))

    if [ $(($vowels_count % 2)) -eq 0 ]; then
        echo true
    else
        echo false
    fi

}

examples=('perl' 'book' 'good morning')

for e in "${examples[@]}"; do
    ss=$(split_string "$e")
    echo "Input  : str = ($e)"
    echo -e "Output : $ss\n"
done

