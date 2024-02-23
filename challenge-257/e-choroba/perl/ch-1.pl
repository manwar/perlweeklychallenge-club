#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub smaller_than_current(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    my %dense_rank;
    my $r = 0;
    for my $i (0 .. $#sorted) {
        ++$r if $sorted[ $i - 1 ] < $sorted[$i];  # Never true for $i = 0,
                                                  # because sorted.
        $dense_rank{ $sorted[$i] } = $r;
    }
    return [map $dense_rank{$_}, @ints]
}

use Test2::V0;
plan 4 + 2;

is smaller_than_current(5, 2, 1, 6), [2, 1, 0, 3], 'Example 1';
is smaller_than_current(1, 2, 0, 3), [1, 2, 0, 3], 'Example 2';
is smaller_than_current(0, 1),       [0, 1],       'Example 3';
is smaller_than_current(9, 4, 9, 2), [2, 1, 2, 0], 'Example 4';

is smaller_than_current(1, 0, 0, 2), [1, 0, 0, 2], 'Duplicate at the beginning';
is smaller_than_current(7, 7, 2, 8), [1, 1, 0, 2], 'Duplicate in the middle';
