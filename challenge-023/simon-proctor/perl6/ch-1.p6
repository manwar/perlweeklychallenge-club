#!/usr/bin.env perl6

use v6;

#| Display help
multi sub MAIN( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Calculate the Nth forward difference series of the given values
multi sub MAIN(
    UInt $n, #= Order to calculate
    *@vals where @vals.all ~~ Int #= List of Integers to calculate from 
) {
    die "N must between 1 and {@vals.elems-1}" unless  0 < $n <= @vals.elems-1;
    for ^$n {
        @vals = @vals.rotor(2=>-1).map( { [R-] |$_ } )
    }
    say @vals.join(",");
}
