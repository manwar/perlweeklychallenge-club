#!/bin/env raku

unit sub MAIN(Str:D $s);

my %count = $s.comb.rotor(2 => -1).map(-> (\A,\B){ A~B if B.ord == A.ord + 1 }).Bag;
put %count.keys.sort({ -%count{$_}, $_ }).first;
