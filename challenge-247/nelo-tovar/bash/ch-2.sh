#!/usr/bin/env bash 
#
# The Weekly Challenge 247 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
#
# Task 2 : Most Frequent Letter Pair

function most_frecuent_letter_pair() {
    local s=$1 
    local length=$((${#s} - 1))
    local pair=''
    local occurrence=0

    for (( i = 0; i < $length; i++ )); do
        letters=${s:$i:2}

        count=$(echo $s | grep -o $letters | wc -l)
        if [ $count -gt $occurrence ]; then
            pair=$letters
            occurrence=$count
        elif [[ $count -eq $occurrence && $letters < $pair ]]; then
            pair=$letters
        fi
    done

    echo $pair
}

example1='abcdbca'
example2='cdeabeabfcdfabgcd'

for e in "$example1" "$example2"; do
    array=($e)
    pair=$(most_frecuent_letter_pair $e)
    echo "Input  : s = $e"
    echo -e "Output : $pair\n"
done

