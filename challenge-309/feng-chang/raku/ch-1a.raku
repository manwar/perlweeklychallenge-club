#!/bin/env raku

unit sub MAIN(*@ints);

put @ints[@ints.rotor(2 => -1).map({ .[1] - .[0] }).min(:k).first + 1];
