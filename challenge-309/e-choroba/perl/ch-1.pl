#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub mini_gap(@ints) {
    my @gap = (1, $ints[1] - $ints[0]);
    for my $i (2 .. $#ints) {
        @gap = ($i, $ints[$i] - $ints[ $i - 1 ])
            if $ints[$i] - $ints[ $i - 1 ] < $gap[1];
    }
    return $ints[ $gap[0] ]
}

use Test::More tests => 3 + 1;

is mini_gap(2, 8, 10, 11, 15), 11, 'Example 1';
is mini_gap(1, 5, 6, 7, 14), 6, 'Example 2';
is mini_gap(8, 20, 25, 28), 28, 'Example 3';

is mini_gap(2, 3, 10, 12, 13), 3, 'Leftmost';
