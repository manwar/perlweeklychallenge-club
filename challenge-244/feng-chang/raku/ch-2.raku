#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.combinations(1..Inf).map({ .max² * .min }).sum;
