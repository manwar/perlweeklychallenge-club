#!/usr/bin/env raku

use v6;

sub bit-diff( UInt $a, UInt $b ) {
    [+] ($a +^ $b).base(2).comb;
}

#| Give the sum of the differences in bits between all the combinations of inputs
sub MAIN (
    *@vals where { $_.all ~~ UInt } #= Integer values to combine
){
    say [+] @vals.combinations(2).map( { bit-diff( |@_ ) } );
}

