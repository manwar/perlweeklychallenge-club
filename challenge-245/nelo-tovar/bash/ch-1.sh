#!/usr/bin/env bash 
#
# The Weekly Challenge 245 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/
#
# Task 1 : Sort Language 

function sort_languages() {
    local languages=(${!1})
    local popularity=(${!2})
    local length=${#languages[@]}
    local sorted=()

    for (( i = 0; i < $length; i++ )); do
        sorted[${popularity[$i]}]=${languages[$i]}
    done

    echo ${sorted[@]} 
}

example_l_1='perl c python'
example_p_1='2 1 3'

example_l_2='c++ haskell java'
example_p_2='1 3 2'

#for e in "$example1" "$example2" "$example3"; do
for e in 1 2; do
    v_l="example_l_$e"
    v_p="example_p_$e"
    sl=($(sort_languages $v_l $v_p))
    echo "Input  : lang = (${!v_l})"
    echo "         popularity = (${!v_p})"
    echo "Output : (${sl[@]})"
    echo ""
done

