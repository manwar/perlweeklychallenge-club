#!/bin/env raku

unit sub MAIN(*@ints);

put (1..+@ints-2).map({ ([<] @ints[0..$_]) && ([>] @ints[$_..*]) }).any.Bool.lc;
