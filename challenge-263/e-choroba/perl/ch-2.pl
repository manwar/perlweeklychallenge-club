#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub merge_items($items1, $items2) {
    my %merge;
    for my $tuple (@$items1, @$items2) {
        $merge{ $tuple->[0] } += $tuple->[1];
    }
    return [map [$_ => $merge{$_}], keys %merge]
}

use Test2::V0;
plan 3;

is merge_items([[1, 1], [2, 1], [3, 2]],
               [[2, 2], [1, 3]]),
    bag { item $_ for [1, 4], [2, 3], [3, 2] },
    'Example 1';

like merge_items([[1, 2], [2, 3], [1, 3], [3, 2] ],
                 [[3, 1], [1, 3] ]),
    bag { item $_ for [1, 8], [2, 3], [3, 3] },
    'Example 2';

is merge_items([[1, 1], [2, 2], [3, 3]],
               [[2, 3], [2, 4]]),
    bag { item $_ for [1, 1], [2, 9], [3, 3] },
    'Example 3';
