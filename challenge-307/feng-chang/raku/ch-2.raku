#!/bin/env raku

unit sub MAIN(*@words);

put +@words.map(*.comb.Bag).unique(with => &[eqv]);
