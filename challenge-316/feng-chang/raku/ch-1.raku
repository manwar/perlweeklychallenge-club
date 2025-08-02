#!/bin/env raku

unit sub MAIN(*@words);

put ?@words.rotor(2 => -1).map({ .[0].substr(*-1) eq .[1].substr(0,1) }).all;
