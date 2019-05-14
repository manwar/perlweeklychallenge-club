#!/usr/bin/env perl6

use v6;

multi sub is-niven( 0 ) { False }

multi sub is-niven( Int $num where * > 0 ) {
    $num %% [+] $num.comb;
}

sub MAIN( UInt() $max=50 ) {
    .say if is-niven($_) for 0..$max;
}
