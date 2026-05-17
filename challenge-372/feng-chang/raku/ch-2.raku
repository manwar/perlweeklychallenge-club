#!/bin/env raku

unit sub MAIN(Str:D $str);

my @s = $str.comb;
put @s.unique.map({ @s.first($_, :k, :end) - @s.first($_, :k) - 1 }).max;
