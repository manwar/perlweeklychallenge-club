#!/bin/env raku

unit sub MAIN(*@ints);

my ($x, $y) = @ints.splice(*-2, 2);
put @ints[$x..$y].sum;
