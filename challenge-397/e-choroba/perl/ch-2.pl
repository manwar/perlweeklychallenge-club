#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub binary_reflection(@arr) {
    map $_->[0],
    sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
    map [$_, scalar reverse sprintf '%b', $_],
    @arr
}

use Test2::V0;
plan(5);

is [binary_reflection(3, 6, 12)], [3, 6, 12], 'Example 1';
is [binary_reflection(1, 2, 4, 8)], [1, 2, 4, 8], 'Example 2';
is [binary_reflection(7, 8, 9, 10)], [8, 10, 7, 9], 'Example 3';
is [binary_reflection(5, 9, 15, 17)], [5, 9, 15, 17], 'Example 4';
is [binary_reflection(11, 13, 14, 19)], [14, 13, 11, 19], 'Example 5';
