#!/bin/env raku

unit sub MAIN(Str:D \str);

my @freq = str.comb.Bag.values;
my @u = @freq.unique;

put +(+@u == 2 and abs([-] @u) == 1 and @freq.grep(@freq.max) == 1);
