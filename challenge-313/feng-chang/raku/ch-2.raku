#!/bin/env raku

unit sub MAIN(Str:D $s);

my @s = $s.comb;
my @ndx = (^+@s).grep({ @s[$_] ~~ ('a'..'z')|('A'..'Z') });
@s[@ndx] = @s[@ndx].reverse;
put @s.join;
