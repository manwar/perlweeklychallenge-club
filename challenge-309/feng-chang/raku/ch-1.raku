#!/bin/env raku

unit sub MAIN(*@ints);

put @ints[(1..^+@ints).map({ @ints[$_] - @ints[$_-1] }).min(:k).first + 1];
