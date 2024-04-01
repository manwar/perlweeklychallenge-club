#!/bin/env raku

unit sub MAIN(*@words);

put @words.combinations(2).grep({ .[0].comb ≡ .[1].comb }).join("\n");
