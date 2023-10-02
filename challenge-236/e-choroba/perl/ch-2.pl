#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub array_loops(@ints) {
    my $count;
    my @visited;
    for my $i (0 .. $#ints) {
        next if $visited[$i];

        # Found a new loop. Visit all the members.
        ++$count;
        while (! $visited[$i]) {
            $visited[$i] = 1;
            $i = $ints[$i];
        }
    }
    return $count
}

use Test::More tests => 3;

is array_loops(4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11,
               1, 12, 2, 9, 10),
    3, 'Example 1';
is array_loops(0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17,
               5, 3, 18, 15, 19),
    6, 'Example 2';
is array_loops(9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16,
               1, 0, 15, 6, 17),
    1, 'Example 3';
