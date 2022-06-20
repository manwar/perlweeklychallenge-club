#! /usr/bin/env raku

# Achilles numbers
# https://oeis.org/A052486

use Prime::Factor;

sub is-achilles ($n) {

                2 ≤ .min and
                1 == [gcd] $_
    given cache values bag prime-factors $n

}

(2 .. ∞)
    .grep( &is-achilles )
    .head(           20 )
    .put
