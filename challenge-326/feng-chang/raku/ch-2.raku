#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.rotor(2).map({ .[1] xx .[0] }).flat;
