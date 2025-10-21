#!/bin/env raku

unit sub MAIN(Str:D $src, Str:D $tgt);

use MONKEY-SEE-NO-EVAL;

my @a = EVAL $src;
my @t = EVAL $tgt;
put so @t.join == @a.map(*.join).permutations.map(*.join).any;
