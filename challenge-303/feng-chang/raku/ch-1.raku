#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.combinations(3)».permutations[*;*]».join.unique.grep({ 100 ≤ $_ ≤ 999 && $_ %% 2 }).sort.join(',');
