#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub peak_positions(@ints) {
    my @peaks;
    for my $i (0 .. $#ints) {
        if (($i == 0 || $ints[ $i - 1 ] < $ints[$i])
            && ($i == $#ints || $ints[$i] > $ints[ $i + 1 ])) {
            push @peaks, $i;
        }
    }
    return @peaks
}

use Test2::V0;
plan(5);

is [peak_positions(1, 3, 2)], [1], 'Example 1';
is [peak_positions(2, 4, 6, 5, 3)], [2], 'Example 2';
is [peak_positions(1, 2, 3, 2, 4, 1)], [2, 4], 'Example 3';
is [peak_positions(5, 3, 1)], [0], 'Example 4';
is [peak_positions(1, 5, 1, 5, 1, 5, 1)], [1, 3, 5], 'Example 5';
