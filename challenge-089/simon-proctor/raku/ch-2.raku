#!/usr/bin/env raku

use v6;

#| Print a 3x3 grid of the number 1-9 where each horizontal, vertical and diagonal adds up to 15
sub MAIN( Bool :a(:$all) = False ) {
    for (1..9).permutations().race().grep( -> @grid {  [==] ( 15, |@grid[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]].map( -> @a { [+] @a } ) ) } ) -> @grid {
        say @grid.rotor(3).map( *.join( " " ) ).join("\n");
        exit unless $all;
        say '---';
    }
}
