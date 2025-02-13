#!/bin/env raku

unit sub MAIN(*@ints);

my @orig = @ints.pop;
@orig.push(@orig[*-1] +^ @ints.shift) while @ints;
put @orig;
