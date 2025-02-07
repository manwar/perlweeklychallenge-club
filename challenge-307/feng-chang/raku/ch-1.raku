#!/bin/env raku

unit sub MAIN(*@ints);

put (^+@ints).grep({ @ints[$_] != @ints.sort[$_] });
