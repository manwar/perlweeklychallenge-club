#!/bin/env raku

unit sub MAIN(*@ints);

my \Max = @ints.max;
put((so @ints.grep(*!=Max).all ≤ Max/2) ?? Max !! -1);
