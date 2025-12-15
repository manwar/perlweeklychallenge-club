#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ minmax };
use List::Util qw{ sum };

sub special_average(@ints) {
    my ($min, $max) = minmax(@ints);
    my @filtered = grep $_ != $min && $_ != $max, @ints;
    return 0 unless @filtered;

    return sum(@filtered) / @filtered
}

use Test::More tests => 5;

is special_average(8000, 5000, 6000, 2000, 3000, 7000), 5250, 'Example 1';
is special_average(100_000, 80_000, 110_000, 90_000), 95_000, 'Example 2';
is special_average(2500, 2500, 2500, 2500), 0, 'Example 3';
is special_average(2000), 0, 'Example 4';
is special_average(1000, 2000, 3000, 4000, 5000, 6000), 3500, 'Example 5';
