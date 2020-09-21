#!/usr/bin/env raku

use v6;

#| Count the total numbrer of set bits of the binary representations of all numbers from 1 to $N and return $total_count_set_bit % 1000000007
sub MAIN (
    UInt $N #= Max number to count up to
) {
    say ( [+] (1..$N).race.map( *.base(2).comb ).flat ) % 1000000007
}
