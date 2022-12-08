#!/usr/bin/env perl
package challenge194::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(first);

use Test::More tests => 6;

is( digital_clock('?5:00'), 1, "Example 1" );
is( digital_clock('?3:00'), 2, "Example 2" );
is( digital_clock('1?:00'), 9, "Example 3" );
is( digital_clock('2?:00'), 3, "Example 4" );
is( digital_clock('12:?5'), 5, "Example 5" );
is( digital_clock('12:5?'), 9, "Example 6" );

sub digital_clock ($x) {
    my sub findMissingIndex ($s) {
        first { substr( $s, $_, 1 ) eq '?' } 0 .. length $s;
    }

    my ( $hour, $min ) = split( ':', $x );
    if ( defined( my $idx = findMissingIndex($hour) ) ) {
        if ( $idx == 0 ) {
            return 2 if substr( $hour, 1, 1 ) <= 3;
            return 1;
        }

        return 3 if substr( $hour, 0, 1 ) == 2;
        return 9;
    }

    if ( defined( my $idx = findMissingIndex($min) ) ) {
        return 5 if $idx == 0;

        return 9;
    }
}
