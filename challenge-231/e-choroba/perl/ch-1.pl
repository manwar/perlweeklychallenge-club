#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ minmax };

sub min_max (@ints) {
    my ($min, $max) = minmax(@ints);
    my @not_boundary = grep $_ != $min && $_ != $max, @ints;
    return @not_boundary ? \@not_boundary : -1
}

use Test2::V0;
plan 3 + 1;

is min_max(3, 2, 1, 4), [3, 2], 'Example 1';
is min_max(3, 1), -1, 'Example 2';
is min_max(2, 1, 3), [2], 'Example 3';

is min_max(1), -1, 'Single number';
