#!/bin/env raku

unit sub MAIN(Str:D $str);

put $str.comb.grep(/<[0..9]>/).unique.sort[*-2] // -1;
