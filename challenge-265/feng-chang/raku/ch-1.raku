#!/bin/env raku

unit sub MAIN(*@ints);

my %counts = @ints.Bag;
put %counts.keys».Int.grep({ %counts{$_}/+@ints ≥ 0.33 }).min;
