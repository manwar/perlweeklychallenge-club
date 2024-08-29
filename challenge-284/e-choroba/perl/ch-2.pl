#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub relative_sort($list1, $list2) {
    my %freq;
    ++$freq{$_} for @$list1;

    return [map(($_) x (delete $freq{$_} // 0), @$list2),
            map +($_) x $freq{$_}, sort { $a <=> $b } keys %freq]
}

use Test2::V0;
plan(3 + 1);

is relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
                 [2, 1, 4, 3, 5, 6]),
    [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9],
    'Example 1';

is relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3],
                 [1, 3, 2]),
    [1, 3, 3, 3, 2, 2, 4, 4, 6],
    'Example 2';

is relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1],
                 [1, 0, 3, 2]),
    [1, 1, 1, 0, 0, 3, 2, 4, 5],
    'Example 3';

is relative_sort([3, 2, 1],
                 [0, 1, 4, 2, 5, 3, 6]),
    [1, 2, 3],
    'Shorter list, missing elements';
