#!/bin/env raku

my @padovans = 1, 1, 1, -> $a,$b,$ { $a + $b } … ∞;
put @padovans.grep(*.is-prime).unique[^10];
