#!/bin/env raku

unit sub MAIN(*@strs);

put +([Z] @strs».comb).grep({ ![lt] $_ });
