#!/bin/env raku

unit sub MAIN(Str:D $x, Str:D $y);

my @x = $x.comb(/\d+/);
my @y = $y.comb(/\d+/);
put (@y.sum - @x.sum) / +@x;
