#! /usr/bin/env perl6

subset AtoZ of Str where /^ <[A .. Z a .. z]>+ $/;

unit sub MAIN (AtoZ $alphabet, AtoZ $string);

say ($alphabet.comb.Set ⊍ $string.comb.Bag).Int;
