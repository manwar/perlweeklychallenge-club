#!/usr/bin/env raku
use v6;
subset PosInt of Int where * > 0;
subset PosDigit of Int where 0 < * <= 9;

sub divisors-for (PosInt:D $n) {
   (1 .. $n.sqrt.Int).grep({$n %% $_}).map({$_, ($n / $_).Int})
     .flat.Set.keys;
}

sub MAIN (PosInt:D $m = 24, PosDigit:D $n = 2) {
   divisors-for($m).grep({.substr(*-1, 1) == $n}).elems.put;
}
