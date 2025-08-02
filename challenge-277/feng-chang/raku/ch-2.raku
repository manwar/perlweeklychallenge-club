#!/bin/env raku

unit sub MAIN(*@ints);

put +@ints.unique.combinations(2).grep(-> (\a,\b) { abs(a - b) < min(a, b) });
