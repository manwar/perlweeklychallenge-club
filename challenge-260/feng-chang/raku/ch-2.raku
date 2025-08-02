#!/bin/env raku

unit sub MAIN(Str:D $w);

put $w.comb.permutations».join.unique.sort.first($w, :k) + 1;
