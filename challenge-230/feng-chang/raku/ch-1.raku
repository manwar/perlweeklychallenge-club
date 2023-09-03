#!/bin/env raku

unit sub MAIN(*@ints);

put @ints».comb.flat;
