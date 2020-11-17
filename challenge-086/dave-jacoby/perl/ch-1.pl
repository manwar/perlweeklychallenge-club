#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

say pair_difference( 7,  ( 10, 8,  12, 15, 5 ) );
say pair_difference( 6,  ( 1,  5,  2,  9,  7 ) );
say pair_difference( 15, ( 10, 30, 20, 50, 40 ) );

sub pair_difference ( $A, @N ) {
    say join ' ', '     ', $A, '--', @N;
    while (@N) {
        my $n = shift @N;
        for my $o (@N) {
            return 1 if $A == $n - $o;
            return 1 if $A == $o - $n;
        }
    }

    return 0;
}
