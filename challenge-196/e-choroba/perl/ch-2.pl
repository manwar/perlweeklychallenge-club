#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub range_list ($arr) {
    my @ranges = ([shift @$arr]);
    for my $r (@$arr, $ranges[0][0] - 1) {
        if ($r == $ranges[-1][-1] + 1) {
            $ranges[-1][1] = $r;
        } else {
            my $is_range = 2 == @{ $ranges[-1] };
            splice @ranges, $is_range ? $#ranges + 1 : $#ranges, 1, [$r];
        }
    }
    pop @ranges;
    return \@ranges
}

use Test2::V0; plan 3 + 2;

is range_list([1, 3, 4, 5, 7]), [[3, 5]], 'Example 1';
is range_list([1, 2, 3, 6, 7, 9]), [[1, 3], [6, 7]], 'Example 2';
is range_list([0, 1, 2, 4, 5, 6, 8, 9]), [[0, 2], [4, 6], [8, 9]], 'Example 3';

is range_list([1, 3, 5, 7]), [], 'Empty';
is range_list([1 .. 10]), [[1, 10]], 'Full';
