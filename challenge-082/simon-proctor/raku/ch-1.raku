#!/usr/bin/env raku

use v6;

#| Given two positive integers print the common factors (not including the values themselves).
sub MAIN ( UInt $M, UInt $N ) {
    say "({(fac($M) (&) fac($N)).keys.sort.join(', ')})"
}

sub fac( UInt $v ) {
    (1..^$v).grep( $v %% * )
}
