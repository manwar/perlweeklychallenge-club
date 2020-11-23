#!/bin/env raku

my @N;
@N.push($_.words.Array) for $*IN.lines;

my @A;
while (@N) {
    @A.push($_) for @N.shift.Array;
    last unless @N[0].elems > 0;

    @A.push(@N[$_].pop) for ^@N.elems;
    last unless @N.elems > 0;

    @A.push($_) for @N.pop.Array.reverse;
    last unless @N[0].elems > 0;

    @A.push(@N[$_].shift) for @N.elems^...0;
}

put @A;
