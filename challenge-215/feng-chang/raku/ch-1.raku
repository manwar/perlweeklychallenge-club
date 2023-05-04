#!/bin/env raku

unit sub MAIN(*@S);

put +@S.grep({ ![lt] .comb });
