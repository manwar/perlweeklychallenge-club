#!/bin/env raku

unit sub MAIN(*@ints where @ints.all ≥ 0);

put @ints.combinations.grep(*.join %% 3).map({ .permutations.map(*.join) }).flat.max || -1;
