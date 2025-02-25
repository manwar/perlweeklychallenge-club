#!/bin/env raku

unit sub MAIN(*@ints);

my $n = @ints.pop;
put @ints.rotor($n => 1-$n).map({ .sum / .elems }).max; 
