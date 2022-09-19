#!/usr/bin/env raku

my $p := 3, 0, 2, -> $a, $b, $ { $a + $b } ... *;

say $p.grep(&is-prime).unique.head(13).sort;
