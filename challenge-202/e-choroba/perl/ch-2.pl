#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub widest_valley($profile) {
    my @widest = (1, 0);
    my $from = 0;
    while ($from <= $#$profile) {
        my $to = my $deepest = my $flat_from = $from;
        while ($to <= $#$profile
               && ($deepest >= $to - 1
                   || $profile->[$to] >= $profile->[ $to - 1 ])
        ) {
            $deepest = $to if $profile->[$to] <= $profile->[$deepest];
            $flat_from = $to unless $profile->[$to] == $profile->[ $to - 1 ];
            @widest = ($from, $to) if $to - $from > $widest[1] - $widest[0];
            ++$to;
        }
        $from = $to > $#$profile ? $to : $flat_from;
    }
    return [@$profile[ $widest[0] .. $widest[1] ]]
}

use Test2::V0;
plan 5 + 4;
is widest_valley([1, 5, 5, 2, 8]), [5, 5, 2, 8], 'Example 1';
is widest_valley([2, 6, 8, 5]), [2, 6, 8], 'Exapmle 2';
is widest_valley([9, 8, 13, 13, 2, 2, 15, 17]),
    [13, 13, 2, 2, 15, 17],
    'Example 3';
is widest_valley([1, 3, 3, 2, 1, 2, 3, 3, 2]), [3, 3, 2, 1, 2, 3, 3],
    'Example 4';
is widest_valley([2, 1, 2, 1, 3]), [2, 1, 2], 'Example 5';

is widest_valley([]), [], 'Empty';
is widest_valley([1, 1]), [1, 1], 'Flat';
is widest_valley([1, 2]), [1, 2], 'Increasing';
is widest_valley([2, 1]), [2, 1], 'Decreasing';
