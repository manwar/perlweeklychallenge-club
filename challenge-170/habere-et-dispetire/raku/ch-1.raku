#! /usr/bin/env raku

# Primorial numbers
# https://oeis.org/A002110

(1 .. ∞)
    .grep( 1 | &is-prime )
    .produce( &[×] )
    .head( 10 )
    .put
