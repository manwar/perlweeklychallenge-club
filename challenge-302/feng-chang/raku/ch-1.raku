#!/bin/env raku

unit sub MAIN(*@binaries);

my $y = @binaries.pop;
my $x = @binaries.pop;

put @binaries.combinations.grep({ ([(+)] .map(*.comb.Bag)) (<=) (0 => $x, 1 => $y).Hash })».elems.max;
