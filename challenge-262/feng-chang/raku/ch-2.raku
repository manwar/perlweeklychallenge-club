#!/bin/env raku

unit sub MAIN(*@ints);

my \k = @ints.pop;
put +(^+@ints).combinations(2).grep(-> (\a,\b) { @ints[a] == @ints[b] and a*b %% k });
