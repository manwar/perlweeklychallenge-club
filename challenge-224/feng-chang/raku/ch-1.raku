#!/bin/env raku

unit sub MAIN(Str:D $src, Str:D $tgt);

put $tgt.comb.Bag (<=) $src.comb.Bag;
