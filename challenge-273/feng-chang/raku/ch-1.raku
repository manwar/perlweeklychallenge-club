#!/bin/env raku

unit sub MAIN(Str:D $s, Str:D $c where $c.chars == 1);

put ($s.comb.Bag{$c} / $s.chars * 100 + 0.5).Int;
