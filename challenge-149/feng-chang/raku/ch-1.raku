#!/bin/env raku

unit sub MAIN(UInt:D \N);

my @fibs = (0, 1, * + * ... *)[^N];
put (^Inf).grep({ @fibs.grep(.comb.sum) })[^N];
