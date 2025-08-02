#!/bin/env raku

unit sub MAIN(Str:D $str);

put $str.lc.comb.squish.elems - 1;
