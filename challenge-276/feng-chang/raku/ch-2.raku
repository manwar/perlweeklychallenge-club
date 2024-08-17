#!/bin/env raku

unit sub MAIN(*@ints);

my %b = @ints.Bag;
my \maxc = %b.values.max;
put +%b.values.grep(maxc) * maxc;
