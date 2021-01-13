#!/usr/bin/env perl

use v5.30;
use warnings;

use List::Util 'min', 'max';

my @S = (
    [1, 5],
    [7, 9],
);

my $N = [10, 11];

push @S, $N;

LOOP:
{
    # check all pairs of intervals, whether they merge
    for (my $i = 0; $i < @S - 1; $i++) {
        for (my $j = $i + 1; $j < @S; $j++) {
            my $pair_a = $S[$i];
            my $pair_b = $S[$j];

            # do they touch?
            if ($pair_a->[1] >= $pair_b->[0] and $pair_a->[0] <= $pair_b->[1]) {
                # merge the two intervals and start over
                my $min = min($pair_a->[0], $pair_b->[0]);
                my $max = max($pair_a->[1], $pair_b->[1]);
                splice @S, $j, 1;
                splice @S, $i, 1;
                push @S, [$min, $max];

                redo LOOP;
            }
        }
    }
}

# sort intervals
@S = sort {$a->[0] <=> $b->[0]} @S;

# display them
say join(", ", map {"($_->[0],$_->[1])"} @S);
