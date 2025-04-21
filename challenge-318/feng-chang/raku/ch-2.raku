#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

my @source = $s1.comb(/\d+/);
my @target = $s2.comb(/\d+/);
@source[(^+@source).grep({ @source[$_] != @target[$_] }).minmax] .= reverse;
put @source eqv @target;
