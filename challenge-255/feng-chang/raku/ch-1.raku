#!/bin/env raku

unit sub MAIN(Str:D $s, Str:D $t);

put ($t.comb.Bag (-) $s.comb.Bag).first.key;
