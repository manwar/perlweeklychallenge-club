#!/bin/env raku

unit sub MAIN(*@words);

put @words.map({ .comb.Bag }).reduce(&infix:<(&)>).map({ .key xx .value }).flat.sort;
