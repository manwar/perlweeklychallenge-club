#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.sum - @ints».comb».sum.sum;
