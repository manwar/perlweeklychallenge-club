#!/usr/bin/env bash 
#
# The Weekly Challenge 255 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
#
# Task 2 : Most Frequent Word

function most_frequent_word() {
    local p=($1)
    local w=$2
    declare -A most_frequent=([max]=0 [word]='')
    declare -A frequency=()

    for i in ${p[@]}; do
        [[ $i =~ ([a-zA-Z]+).* ]]
        word=${BASH_REMATCH[1]}
        
        if [[ "$word" != "$w" ]]; then
            ((frequency[$word]++))
        fi
    done

    for key in "${!frequency[@]}"; do
        if [ ${frequency[$key]}  -gt ${most_frequent[max]} ]; then
            most_frequent[max]=${frequency[$key]}
            most_frequent[word]=$key
        fi
    done

    echo ${most_frequent[word]}

}

example_p=('Joe hit a ball, the hit ball flew far after it was hit.' 
           'Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.')
example_w=('hit' 'the')

for i in 0 1; do
    p=${example_p[$i]} 
    w=${example_w[$i]} 
    
    mfw=$(most_frequent_word "$p" "$w")
    echo "Input  : p = $p"
    echo "         w = $w"
    echo -e "Output : $mfw\n"
done

