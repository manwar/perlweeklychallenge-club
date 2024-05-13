#!/bin/env raku

unit sub MAIN(*@ints);

put so +@ints.grep(* %% 2) > 1;
