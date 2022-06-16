#! /usr/bin/env raku

# Brilliant numbers

use Prime::Factor;

sub is-brilliant ($n) {

           .elems == 2 and
        [==] .map: *.chars
    given prime-factors $n

}

say (1 .. ∞)
    # https://oeis.org/A078972
    .grep(&is-brilliant)
    .head(20)
