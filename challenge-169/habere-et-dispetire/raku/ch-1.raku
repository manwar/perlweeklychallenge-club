#! /usr/bin/env raku

# Brilliant numbers
# https://oeis.org/A078972

use Prime::Factor;

sub is-brilliant ($n) {

           .elems == 2 and
        [==] .map: *.chars
    given prime-factors $n

}

(1 .. ∞)
    .grep( &is-brilliant )
    .head(            20 )
    .put
