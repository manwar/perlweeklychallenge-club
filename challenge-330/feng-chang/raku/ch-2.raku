#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.words.map({ .chars == 1|2 ?? .lc !! .tclc }).join(' ');
