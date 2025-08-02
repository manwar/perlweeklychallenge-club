#!/usr/bin/env bash 
#
# The Weekly Challenge 274 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-274/
#
# Task 1 : Goat Latin

repeat(){
    for i in $(seq 1 $2); do echo -n "$1"; done
}

function goat_latin() {
    local sentence="$@"
    local gl='' 
    local words=()
    for i in $sentence; do
        words+=($i)
    done
    local length=${#words[@]}

    for (( i = 0; i < $length; i++ )); do
        if [[ ${words[$i]} =~ ^[AEIOUaeiou] ]]; then
            gl+=${words[$i]}
        echo "Processing ${words[$i]} - $gl" >&2
        else
            gl+="${words[$i]:1}${words[$i]:0:1}"
        fi

        ((b=i+1))
        gl+="ma$(repeat a $b) "
    done

    echo $gl
}

examples=('I love Perl' 'Perl and Raku are friends' 'The Weekly Challenge')

for e in "${examples[@]}"; do
    gl=$(goat_latin "$e")
    echo "Input  : sentence = $e"
    echo "Output : $gl"
    echo ""
done

