#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use enum qw( COUNT VALUE );

sub max_gap (@list) {
    return 0 if @list < 2;

    my @sorted = sort { $a <=> $b } @list;
    my @max = (0, -1);
    for my $i (1 .. $#sorted) {
        my $diff = $sorted[$i] - $sorted[ $i - 1 ];
        @max = @{ (
            [$max[COUNT] + 1, $diff],
            [1, $diff],
            \@max
        )[ $diff <=> $max[VALUE] ] };
    }
    return $max[COUNT]
}

use Test::More tests => 2 + 2;

is max_gap(2,5,8,1), 2, 'Example 1';
is max_gap(3), 0, 'Example 2';

is max_gap(), 0, 'Empty';
is max_gap(1, 1, 1, 1), 3, 'gap = 0';
