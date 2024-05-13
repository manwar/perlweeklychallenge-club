#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub distribute_elements(@ints) {
    my @arr1 = shift @ints;
    my @arr2 = shift @ints;
    while (@ints) {
        push @{ $arr1[-1] > $arr2[-1] ? \@arr1 : \@arr2 }, shift @ints;
    }
    return @arr1, @arr2
}

use Test2::V0;
plan(3);

is [distribute_elements(2, 1, 3, 4, 5)], [2, 3, 4, 5, 1], 'Example 1';
is [distribute_elements(3, 2, 4)], [3, 4, 2], 'Example 2';
is [distribute_elements(5, 4, 3 ,8)], [5, 3, 4, 8], 'Example 3';
