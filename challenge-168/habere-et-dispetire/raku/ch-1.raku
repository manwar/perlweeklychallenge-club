#! /usr/bin/env raku

# Perrin Prime
# https://wikiless.org/wiki/Perrin_number
# https://oeis.org/A074788

put (3, 0, 2, -> $n3, $n2, $ { $n3 + $n2 } … ∞)
    .grep(*.is-prime)
    .unique
    .head(13)
    .sort;
