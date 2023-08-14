#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub find_highest_digit {
    my ($time) = @_;
    my ( $hour, $minute ) = split( ':', $time );

    # Handle the hour part
    if ( $hour =~ /^\?(\d)$/ ) {
        my $units_digit = $1;
        if ( $units_digit <= 3 ) {
            return 2;
        }
        else {
            return 1;
        }
    }
    if ( $hour =~ /\?$/ ) {
        return ( $hour =~ /^1./ ) ? 9 : 3;
    }

    # Handle the minute part
    if ( $minute =~ /^\?/ ) {
        return 5;
    }
    if ( $minute =~ /\?$/ ) {
        return 9;
    }

    return;    # Should never reach here
}

is( find_highest_digit('?5:00'), 1, 'Example 1' );
is( find_highest_digit('?3:00'), 2, 'Example 2' );
is( find_highest_digit('1?:00'), 9, 'Example 3' );
is( find_highest_digit('2?:00'), 3, 'Example 4' );
is( find_highest_digit('12:?5'), 5, 'Example 5' );
is( find_highest_digit('12:5?'), 9, 'Example 6' );

done_testing();
