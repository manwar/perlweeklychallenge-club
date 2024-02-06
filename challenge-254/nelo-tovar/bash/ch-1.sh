#!/usr/bin/env bash 
#
# The Weekly Challenge 254 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
#
# Task 1 : Three Power

function three_power() {
    local number=$1
    local exponent=$2

    for i in $(seq 0 $number); do 
        x=$(($i ** $exponent))
        if [ $x -eq $number ]; then
            echo true
            return
        fi
    done

    echo false 
}

example1='27 0 6'

for e in $example1; do
    po=$(three_power $e 3)
    echo "Input  : $n = $e"
    echo "Output : $po"
    echo ""
done

