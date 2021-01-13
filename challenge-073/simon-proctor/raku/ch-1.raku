#!/usr/bin/env raku

use v6;

# Print the lowest value in each window of the given list of numbers
sub MAIN(
    UInt :$size where { $size > 0 } = 3, #= Size of the sliding window (default 3)
    *@numbers where { @numbers.elems >= $size && @numbers.all ~~ Int  }, #= List of integers to look at
) {
    @numbers.rotor( $size => 1-$size ).map( *.min ).say;
}
    
