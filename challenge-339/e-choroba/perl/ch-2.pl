#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub peak_point(@gain) {
    my $altitude = my $peak = 0;
    for my $g (@gain) {
        $altitude += $g;
        $peak = $altitude if $altitude > $peak;
    }
    return $peak
}

use Test::More tests => 5;

is peak_point(-5, 1, 5, -9, 2), 1, 'Example 1';
is peak_point(10, 10, 10, -25), 30, 'Example 2';
is peak_point(3, -4, 2, 5, -6, 1), 6, 'Example 3';
is peak_point(-1, -2, -3, -4), 0, 'Example 4';
is peak_point(-10, 15, 5), 10, 'Example 5';
