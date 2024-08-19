#!/bin/env raku

unit sub MAIN(*@ints);

put so (^+@ints).map({ +@ints.grep($_) == @ints[$_] }).all;
