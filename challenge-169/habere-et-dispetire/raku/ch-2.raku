#! /usr/bin/env raku

# Achilles numbers

use Prime::Factor;

sub is-achilles ($n) {

                2 ≤ .min and
                1 == [gcd] $_
    given @(values bag prime-factors $n)

}

say (2 .. ∞)
    # https://oeis.org/A052486
    .grep(&is-achilles)
    .head(20)
