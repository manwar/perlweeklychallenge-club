#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub pattern_132 ($list) {
    for my $i (0 .. $#$list - 2) {
        for my $j ($i + 1 .. $#$list - 1) {
            for my $k ($j + 1 .. $#$list) {
                return [@$list[$i, $j, $k]]
                    if $list->[$i] < $list->[$k]
                    && $list->[$k] < $list->[$j];
            }
        }
    }
    return []
}


use Test2::V0; plan 4 + 1;

is pattern_132([3, 1, 4, 2]), [1, 4, 2], 'Example 1';
is pattern_132([1, 2, 3, 4]), [], 'Example 2';
is pattern_132([1, 3, 2, 4, 6, 5]), [1, 3, 2], 'Example 3';
is pattern_132([1, 3, 4, 2]), [1, 3, 2], 'Example 4';

is pattern_132([1, 5, 7, 4]), [1, 5, 4], 'Not 1 7 4';
