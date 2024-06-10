#!/usr/bin/env bash 
#
# The Weekly Challenge 272 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
#
# Task 1 : Defang IP Address

function defang_ip_address() {
    local ip=$1

    echo ${ip//./[.]}
}

examples=('1.1.1.1' '255.101.1.0')

for e in ${examples[@]}; do
    dia=($(defang_ip_address "$e"))
    echo "Input  : ip = $e"
    echo "Output : $dia"
    echo ""
done

