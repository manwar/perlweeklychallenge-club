#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.sort({ .base(2).comb.sum, $_ });
