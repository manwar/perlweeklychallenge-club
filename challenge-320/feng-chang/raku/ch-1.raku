#!/bin/env raku

unit sub MAIN(*@ints);

put max(+.grep(* > 0), +.grep(* < 0)) with @ints;
