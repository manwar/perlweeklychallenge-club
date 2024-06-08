#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub sort_by_1_bits(@ints) {
    map $_->[1],
    sort { $a->[0] <=> $b->[0]
           ||
           $a->[1] <=> $b->[1]
    } map [unpack('%32b*', pack 'N', $_), $_],
    @ints
}

use Test2::V0;
plan(2);

is [sort_by_1_bits(0, 1, 2, 3, 4, 5, 6, 7, 8)], [0, 1, 2, 4, 8, 3, 5, 6, 7],
    'Example 1';
is [sort_by_1_bits(1024, 512, 256, 128, 64)], [64, 128, 256, 512, 1024],
    'Example 2';
