#!/bin/env raku

unit sub MAIN(*@N);

put @N.Bag.values.map({ $_*($_-1)/2 }).sum;
