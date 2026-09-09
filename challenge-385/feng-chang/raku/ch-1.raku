#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

put ($s1.words.Bag (+) $s2.words.Bag).map({ .key if .value == 1 }).sort.join(' ');
