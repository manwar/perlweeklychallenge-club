#!/bin/env raku

unit sub MAIN(*@ints);

put max(+@ints.grep(* > 0), +@ints.grep(* < 0));
