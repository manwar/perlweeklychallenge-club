#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub divisible_average(@arr) {
    my @d = grep 0 == $_ % 2 && 0 == $_ % 3, @arr;
    return 0 unless @d;

    return int sum0(@d) / @d
}

use Test::More tests => 5;

is divisible_average(18, 5, 7, 11), 18, 'Example 1';
is divisible_average(6, 12, 18, 24, 30, 40), 18, 'Example 2';
is divisible_average(3, 9, 15, 21, 27), 0, 'Example 3';
is divisible_average(6, 12, 14, 20), 9, 'Example 4';
is divisible_average(6, 6, 6, 12, 12), 8, 'Example 5';
