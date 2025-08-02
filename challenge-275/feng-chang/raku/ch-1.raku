#!/bin/env raku

unit sub MAIN(*@words);

my @broken = @words.tail.lc.comb;
put +@words.grep(*.lc.comb.any ne @broken.any);
