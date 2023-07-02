#!/usr/bin/env raku
use v6;
sub MAIN (Int() $n where * > 0) { put count-primes($n) }
sub count-primes ($n) { (2 .. $n).grep({ .is-prime }).elems }
