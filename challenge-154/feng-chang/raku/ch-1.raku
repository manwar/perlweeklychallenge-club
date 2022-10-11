#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.e = 'input.txt');

my @words = $f.IO.words».subst(/',' $/);
put @words[0].comb.permutations».join (-) @words;
