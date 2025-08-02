#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub decompressed_list(@ints) {
    my @r;
    while (my ($times, $what) = splice @ints, 0, 2) {
        push @r, ($what) x $times;
    }
    return @r
}

use Test2::V0;
plan(3);

is [decompressed_list(1, 3, 2, 4)], [3, 4, 4], 'Example 1';
is [decompressed_list(1, 1, 2, 2)], [1, 2, 2], 'Example 2';
is [decompressed_list(3, 1, 3, 2)], [1, 1, 1, 2, 2, 2], 'Example 3';
