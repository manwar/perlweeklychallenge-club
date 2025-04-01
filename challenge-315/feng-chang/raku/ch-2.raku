#!/bin/env raku

unit sub MAIN(Str:D $snt, Str:D $w1, Str:D $w2);

my @words = $snt.words;
put (2..^+@words).map({ @words[$_] if @words[$_-2, $_-1] eqv ($w1, $w2) });
