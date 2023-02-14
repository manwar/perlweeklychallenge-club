#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems >= 2 && all(@nums) ~~ /^<[0..9]>*$/);

if    [<=] @nums { say 1; }
elsif [>=] @nums { say 1; }
else             { say 0; }
