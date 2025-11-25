#!/bin/env raku

unit sub MAIN(Str:D $w where *.chars %% 2);

my @vowels = <a e i o u>;
my @w = $w.lc.comb;
put +@w[^+@w/2].grep(@vowels.any) == +@w[+@w/2..*].grep(@vowels.any);
