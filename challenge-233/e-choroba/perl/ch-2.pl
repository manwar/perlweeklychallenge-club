#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub frequency_sort(@ints) {
    my %freq;
    ++$freq{$_} for @ints;
    return [
        sort { $freq{$a} <=> $freq{$b} || $b <=> $a } @ints
    ]
}

use Test2::V0;
plan 3 + 1;

is frequency_sort(1, 1, 2, 2, 2, 3), [3, 1, 1, 2, 2, 2], 'Example 1';
is frequency_sort(2, 3, 1, 3, 2), [1, 3, 3, 2, 2], 'Example 2';
is frequency_sort(-1, 1, -6, 4, 5, -6, 1, 4, 1),
    [5, -1, 4, 4, -6, -6, 1, 1, 1],
    'Example 3';

is frequency_sort(), [], 'Empty';
