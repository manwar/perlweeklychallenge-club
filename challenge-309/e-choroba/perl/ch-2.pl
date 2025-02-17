#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub min_diff(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    return min(map $sorted[$_] - $sorted[ $_ - 1 ], 1 .. $#sorted)
}

use Test::More tests => 2;

is min_diff(1, 5, 8, 9), 1, 'Example 1';
is min_diff(9, 4, 1, 7), 2, 'Example 2';
