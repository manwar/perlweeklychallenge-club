#!/usr/bin.env perl6

use v6;

#| Display help
multi sub MAIN( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Calculate the Nth forward difference series of the given values
multi sub MAIN(
    UInt $n, #= Order to calculate must be between 0 and 1 less than the list length
    *@vals where @vals.all ~~ Int && 0 <= $n <= @vals.elems-1 #= List of Integers to calculate from 
) {
    for ^$n {
        @vals = @vals.rotor(2=>-1).map( { [R-] |$_ } )
    }
    say @vals.join(",");
}
