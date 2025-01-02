#!/bin/env raku

unit sub MAIN(*@ints);

put (1 - ([\+] @ints).min, 1).max;
