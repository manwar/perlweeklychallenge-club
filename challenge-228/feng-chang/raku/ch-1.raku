#!/bin/env raku

unit sub MAIN(*@N);

put @N.Bag.map({ .key if .value == 1 }).sum;
