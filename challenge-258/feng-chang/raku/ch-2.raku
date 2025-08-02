#!/bin/env raku

unit sub MAIN(*@ints);

my \k = @ints.pop;
put @ints[(^+@ints).grep(*.base(2).comb.sum == k)].sum;
