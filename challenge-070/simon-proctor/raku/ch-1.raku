#!/usr/bin/env raku

use v6

#| Given a string, swap count and offset swap characters in the string
sub MAIN (
    Str $S, #= String to manipulate
    UInt $C, #= Swap count
    UInt $O where { $C <= $O && $C + $O <= $S.codes }, #= Offset
) {
    my @swaps = $S.comb;
    my $N = $S.codes;
    for 1..$C -> $i {
        my $x = $i % $N;
        my $y = ($i+$O) % $N;
        @swaps[$x,$y] = @swaps[$y,$x];
    }
    
    @swaps.join("").say;
}
