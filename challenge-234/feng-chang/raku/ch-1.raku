#!/bin/env raku

unit sub MAIN(*@words);

put ([(&)] @words.map({ .comb.Bag })).map({ .key xx .value });
