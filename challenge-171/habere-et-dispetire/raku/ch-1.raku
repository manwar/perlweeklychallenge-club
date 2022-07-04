#! /usr/bin/env raku

# Abundant Numbers

use Prime::Factor;

sub is-abundant ( $n ) {

    proper-divisors( $n ).sum > $n

}

(1 .. ∞)
    .grep( &is-abundant ) # https://oeis.org/A005101
    .head(           20 )
    .put
