#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.combinations(4).map(-> @a { (^4).combinations(2).map(-> @b { abs(([*] @a[@b]) - [*] @a[(^4 (-) @b).keys]) }) }).flat.max;
