#!/bin/env raku

sub dist2(Int:D \x1, Int:D \y1, Int:D \x2, Int:D \y2 --> UInt:D) {
    (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
}

sub is-square(
    Int:D \x1, Int:D \y1,
    Int:D \x2, Int:D \y2,
    Int:D \x3, Int:D \y3,
    Int:D \x4, Int:D \y4
--> Bool:D) {
    [==] dist2(x1,y1,x2,y2), dist2(x2,y2,x3,y3), dist2(x3,y3,x4,y4), dist2(x4,y4,x1,y1)
}

sub MAIN(*@N where *.elems == 8) {
    put + [or] (1..3).permutations.map({ is-square(
        @N[0],      @N[1],
        @N[.[0]*2], @N[.[0]*2+1],
        @N[.[1]*2], @N[.[1]*2+1],
        @N[.[2]*2], @N[.[2]*2+1]
    ) });
}
