#!/usr/bin/env bash 
#
# The Weekly Challenge 277 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
#
# Task 1 - Count Common

function singleton() {
    local array=("$@")
    declare -A local temp
    local single=()

    for n in ${array[@]}; do
        ((temp[$n]++))
    done

    for i in ${!array[@]}; do
        key=${array[$i]}
        if [ ${temp[$key]} -eq 1 ]; then
            single+=($key)
            unset temp[$key]
        fi
    done

    echo ${single[@]}
}
function count_common() {
    local temp=($1)
    local words1=($(singleton ${temp[@]}))
    temp=($2)
    local words2=($(singleton ${temp[@]}))
    local count=0

    for word in ${words1[@]}; do
        if [[ "${words2[@]}" == *"$word"* ]]; then
            ((count++))
        fi
    done

    echo $count
}

examples_w1=('Perl is my friend' 'Perl and Python are very similar' 'Perl is imperative lisp is functional')
examples_w2=('Perl and Raku are friends' 'Python is top in guest languages' 'Crystal is similar to Ruby')

for e in ${!examples_w1[@]}; do
    words1=${examples_w1[$e]}
    words2=${examples_w2[$e]}
    cc=($(count_common "$words1" "$words2"))
    echo "Input  : words1 = ($words1)"
    echo "       : words2 = ($words2)"
    echo "Output : $cc"
    echo ""
done

