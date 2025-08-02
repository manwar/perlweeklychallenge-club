#!/usr/bin/env bash 
#
# The Weekly Challenge 256 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
#
# Task 2 : Merge Strings

function merge_string() {
    local str1=$1
    local len_str1=${#str1}
    local str2=$2
    local len_str2=${#str2}
    local merged=''

    for (( i = 0; i < $len_str1; i++ )); do
        merged+=${str1:$i:1}

        if [ $i -lt $len_str2 ]; then
            merged+=${str2:$i:1}
        fi
    done

    if [ $len_str2 -gt $len_str1 ]; then
        merged+=${str2:$len_str1}
    fi
    echo $merged
}

example1='abcd 1234'
example2='abc 12345'
example3='abcde 123'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    ms=$(merge_string "${array[0]}" "${array[1]}")
    echo "Input  : str1 = ${array[0]} str2 = ${array[1]}"
    echo -e "Output : $ms\n"
done

