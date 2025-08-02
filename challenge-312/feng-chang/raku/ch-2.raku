#!/bin/env raku

unit sub MAIN(Str:D $s);

my @a;
$s.comb.rotor(2).map({ @a[.[1]].push(.[0]) });
put +@a.grep({ .unique.elems == 3 });
