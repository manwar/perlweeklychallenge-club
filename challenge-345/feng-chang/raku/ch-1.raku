#!/bin/env raku

unit sub MAIN(*@ints);

put do { +$_ ?? $_ !! 0 } with (1..+@ints-2).grep({ @ints[$_] > (@ints[$_-1], @ints[$_+1]).all });
