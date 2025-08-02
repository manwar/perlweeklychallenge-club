#!/bin/env raku

unit sub MAIN(*@ints);

with @ints.pairs.map({ .key if .key % 10 == +.value }) { put +$_ ?? .min !! -1 };
