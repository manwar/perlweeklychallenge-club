#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';
use Storable qw{ freeze };

sub unique_array (@arrays) {
    my %seen;
    return [grep ! $seen{ freeze($_) }++, @arrays]
}

use Test2::V0;
plan 3;

is unique_array([1, 2], [3, 4], [5, 6], [1, 2]),
    [[1, 2], [3, 4], [5, 6]],
    'Example 1';
is unique_array([9, 1], [3, 7], [2, 5], [2, 5]),
    [[9, 1], [3, 7], [2, 5]],
    'Example 2';

is unique_array([1, 2, 3], [1, 2], [1, 2, 3]),
    [[1, 2, 3], [1, 2]],
    'More than 2 members';
