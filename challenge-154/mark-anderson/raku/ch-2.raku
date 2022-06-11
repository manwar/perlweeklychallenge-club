#!/usr/bin/env raku

say .grep(*.is-prime).skip.head(10) with

1, 1, 1, -> $a, $b, $ { $a + $b } ... *;
