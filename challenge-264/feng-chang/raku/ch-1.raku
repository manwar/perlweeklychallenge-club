#!/bin/env raku

unit sub MAIN(Str:D $s);

my %s = $s.comb.Set;
my \gel = ('A'..'Z').grep({ %s{.lc} and %s{$_} }).max;
put gel ne '-Inf' ?? gel !! '';
