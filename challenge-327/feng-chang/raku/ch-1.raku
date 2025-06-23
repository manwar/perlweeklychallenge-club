#!/bin/env raku

unit sub MAIN(*@ints);

put ((1..+@ints) (-) +«@ints).keys.sort;
