#!/usr/bin/perl
use warnings;
use strict;

sub consecutive_arrays {
    my @input = @_;
    my @results = ([]);
    for my $i (@input) {
        if (! @{ $results[-1] } || $results[-1][-1] + 1 == $i) {
            push @{ $results[-1] }, $i;
        } else {
            push @results, [$i];
        }
    }
    return \@results
}

use Test2::V0;
plan 4;

is consecutive_arrays(1, 2, 3, 6, 7, 8, 9),
    [[1, 2, 3], [6, 7, 8, 9]],
    'Example 1';

is consecutive_arrays(11, 12, 14, 17, 18, 19),
    [[11, 12], [14], [17, 18, 19]],
    'Example 2';

is consecutive_arrays(2, 4, 6, 8),
    [[2], [4], [6], [8]],
    'Example 3';

is consecutive_arrays(1, 2, 3, 4, 5),
    [[1, 2, 3, 4, 5]],
    'Example 4';
