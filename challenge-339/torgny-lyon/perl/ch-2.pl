#!/usr/bin/perl

use v5.42;

use Test::More tests => 5;

use List::Util qw(max);

sub find_peak_gain {
    my $altitude;
    max(0, map { $altitude += $_ } @_);
}

is(find_peak_gain(-5, 1, 5, -9, 2),    1);
is(find_peak_gain(10, 10, 10, -25),    30);
is(find_peak_gain(3, -4, 2, 5, -6, 1), 6);
is(find_peak_gain(-1, -2, -3, -4),     0);
is(find_peak_gain(-10, 15, 5),         10);
