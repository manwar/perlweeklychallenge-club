#!/bin/env raku

unit sub MAIN(Str:D $w);

my @W = $w.lc.comb;
my @vowels = @W.grep(/<[aeiou]>/, :k);
@W[@vowels] .= reverse;
put @W.join.tc;
