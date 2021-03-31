#!/usr/bin/perl
use warnings;
use strict;

sub maximum_gap {
    my @arr = sort { $a <=> $b } @_;
    my $max = 0;
    for my $i (1 .. $#arr) {
        my $diff = $arr[$i] - $arr[ $i - 1 ];
        $max = $diff if $diff > $max;
    }
    return $max
}

use Test::More tests => 3;
is maximum_gap(2, 9, 3, 5),    4, 'Example 1';
is maximum_gap(1, 3, 8, 2, 0), 5, 'Example 2';
is maximum_gap(5),             0, 'Example 3';
