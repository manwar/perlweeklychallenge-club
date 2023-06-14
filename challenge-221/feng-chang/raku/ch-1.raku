#!/bin/env raku

unit sub MAIN(*@S);

my %chars = @S.pop.comb.Bag;
put @S.grep({ .comb.Bag (<=) %chars })».chars.sum;
