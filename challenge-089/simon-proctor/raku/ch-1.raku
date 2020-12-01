#!/usr/bin/env raku

use v6;

#| Given a number $N print the sum off all the GCD's of all the combinations of 1..$N
sub MAIN ( UInt $N ) {
    say [+] (1..$N).combinations(2).map( -> ( $a, $b ) { $a gcd $b } )
}
