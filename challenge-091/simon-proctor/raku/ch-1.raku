#!/usr/bin/env raku

use v6;

#| Given an unsigned int give the breakdown of number
sub MAIN(
    UInt $N #= Number to read
) {
    my $count = 0;
    my @out;
    for $N.comb -> $n {
        if ! @out || @out[*-1]<v> != $n {
            @out.push( { v => $n, c => 1 } );
        } else {
            @out[*-1]<c>++;
        }        
    }
    say @out.map( -> $p { |($p<c>, $p<v>) } ).join("");
}
