#!/bin/env raku

unit sub MAIN(Str:D $snt, Str:D $w1, Str:D $w2);

put $snt.words.rotor(3 => -2).map({ .[2] if .head(2) eqv ($w1, $w2).Seq });
