#!/usr/bin/env raku

use v6;

#| Given a list of Ints for each item return the smallest item before it in the list or 0 if there is none
sub MAIN (
    *@numbers where { $_.all ~~ Int } #= List of integers to check   
) {
    @numbers.kv.map( -> $i, $v { my $m = @numbers[0..$i].min; $m < $v ?? $m !! 0 } ).say;   
}
