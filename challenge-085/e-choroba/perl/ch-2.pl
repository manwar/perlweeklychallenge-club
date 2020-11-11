#!/usr/bin/perl
use warnings;
use strict;

sub power_of_two_integers {
    my ($n) = @_;
    for my $d (2 .. sqrt $n) {
        next unless $n % $d == 0;

        my $m = $n;
        $m /= $d while $m % $d == 0;
        return 1 if $m == 1;
    }
    return 0
}

use Test::More tests => 7;
is power_of_two_integers(8),   1, 'Example 1';
is power_of_two_integers(15),  0, 'Example 2';
is power_of_two_integers(125), 1, 'Example 3';

is power_of_two_integers(36), 1, 'Collin';
is power_of_two_integers(43), 0, 'Prime';
is power_of_two_integers(987654323), 0, 'Large prime';
is power_of_two_integers(51185893014090757), 1, 'Large PoTI';
