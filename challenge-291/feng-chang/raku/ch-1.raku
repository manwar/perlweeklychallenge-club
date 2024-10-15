#!/bin/env raku

unit sub MAIN(*@ints);

put (^+@ints).first({ @ints[^$_].sum == @ints[$_^..*].sum }) // -1;
