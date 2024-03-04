#!/bin/env raku

unit sub MAIN(*@strs);

my %allowed = @strs.pop.comb.Set;
put +@strs.grep(*.comb.Set (<=) %allowed);
