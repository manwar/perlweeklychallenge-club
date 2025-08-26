#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.Bag.values.reduce(&infix:<gcd>) > 1;
