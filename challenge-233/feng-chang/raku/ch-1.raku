#!/bin/env raku

unit sub MAIN(*@words);

put @words.combinations(2).grep({ .[0].comb.Set eqv .[1].comb.Set }).join("\n");
