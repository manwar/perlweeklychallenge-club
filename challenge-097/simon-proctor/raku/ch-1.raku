#!/usr/bin/env raku

use v6;

#| Given a shift amount (integer can be negative) and a list of string encode using the Ceaser Cypher
sub MAIN(
    Int() $shift is copy, #= Amount to shift the letters by
    *@words where @words.grep({ ! m!^ <[A..Z]>+ $! }).elems == 0 #= Words, all uppercase
) {
    my @alpha = ("A".."Z").Array;
    if ( $shift < 0 ) { $shift = 26+$shift }
    my @shifted = [ |@alpha[(26-$shift)..25], |@alpha[0..(25-$shift)] ];
    
    say @words.map( { $_.trans( @alpha.join => @shifted.join ) } ).join(" ");
}
