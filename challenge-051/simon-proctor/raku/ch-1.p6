#!/usr/bin/env perl6

use v6;

#| Given a target number and a list of integers, print out all the triplets of numbers that add up to the target
sub MAIN (
    Int $target, #= Target number
    *@values where { @values.elems >= 3 && @values.all ~~ Int } #= 3 or more integers numbers to check
) {
    .say for @values.combinations(3).grep( { ([+] $_) == $target } ).map( *.join(",") );
}
