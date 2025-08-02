#!/usr/bin/env bash 
#
# The Weekly Challenge 275 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/
#
# Task 1 : Broken Keys

function broken_keys() {
    local sentence=${1,,}
    local keys=${2,,}
    local count=0

    for i in $sentence; do
        if [[ ! $i =~ [$keys] ]]; then
            ((count++))
        fi
    done

    echo $count
}

examples_sentences=("Perl Weekly Challenge" "Perl and Raku" "Well done Team PWC" "The joys of polyglottism")
examples_keys=('la' 'a' 'lo' 'T')

for e in ${!examples_sentences[@]}; do
    sentence=${examples_sentences[$e]}
    keys=${examples_keys[$e]}
    bk=$(broken_keys "$sentence" "$keys")
    echo "Input  : sentence = '$sentence' keys = $keys "
    echo "Output : $bk"
    echo ""
done

