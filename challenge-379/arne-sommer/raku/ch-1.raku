#! /usr/bin/env raku

unit sub MAIN ($str);

my @input = $str.comb;

print @input.pop while @input;

say "";