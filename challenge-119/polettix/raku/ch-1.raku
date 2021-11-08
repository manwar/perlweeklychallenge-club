#!/usr/bin/env raku
use v6;
sub swap-nibbles (Int:D $N where 0 < $N <= 255) { $N +& 0x0F +< 4 +| $N +> 4 }
my @inputs = @*ARGS ?? @*ARGS !! < 101 18 >;
swap-nibbles(+$_).put for @inputs;
