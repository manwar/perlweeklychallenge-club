#!/bin/env raku

unit sub MAIN(Str:D $str, *@indices where $str.chars == +@indices);

my %m = @indices Z=> ^+@indices;
put $str.comb[%m{%m.keys.sort}].join;
