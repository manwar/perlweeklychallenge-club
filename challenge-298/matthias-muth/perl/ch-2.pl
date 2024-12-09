#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 298 Task 2: Right Interval
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( first );
use Dsay;

sub right_interval_suboptimal( $intervals ) {
    dsay "intervals: ", pp \$intervals;

    # Create a list of the interval indices, sorted by the start_i values
    # of the referenced intervals.
    my @sorted_indices =
        sort { $intervals->[$a][0] <=> $intervals->[$b][0] }
            keys $intervals->@*;
    dsay "  ", "sorted_indices:", pp @sorted_indices;

    # For each interval, use the sorted array to find the index of the first
    # ('right') interval that starts at or after the end_i value
    # of the former.
    return map {
        my $end_i = $_->[1];
        ( first { $intervals->[$_][0] >= $end_i } @sorted_indices ) // -1;
    } $intervals->@*;
}

sub right_interval( $intervals ) {
    # Create a list of the interval indices, sorted by the start_i values
    # of the referenced intervals.
    my @sorted_indices =
        sort { $intervals->[$a][0] <=> $intervals->[$b][0] }
            keys $intervals->@*;

    # Go through the sorted intervals from left to right,
    # looking for the next ('right') interval for each of them.
    # As the intervals there are not in the original order, we place the
    # results into an array at the correct place.
    # Searching from the current position in the sorted array saves a lot of
    # iterations, compared to searching the whole sorted array over and over
    # again from the beginning. The downside is that the code is a bit longer.
    my @results;
    for my $si_i ( 0..$#sorted_indices ) {
        my $i = $sorted_indices[$si_i];
        my $end_i = $intervals->[$i][1];
        $results[$i] =
            ( first { $intervals->[$_][0] >= $end_i }
                @sorted_indices[ $si_i .. $#sorted_indices ] )
                // -1;
    }
    return @results;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ right_interval( [[3, 4], [2, 3], [1, 2]] ) ], [ -1, 0, 1 ],
    'Example 1: right_interval( [[3, 4], [2, 3], [1, 2]] ) == (-1, 0, 1)';
is [ right_interval( [[1, 4], [2, 3], [3, 4]] ) ], [ -1, 2, -1 ],
    'Example 2: right_interval( [[1, 4], [2, 3], [3, 4]] ) == (-1, 2, -1)';
is [ right_interval( [[1, 2]] ) ], [ -1 ],
    'Example 3: right_interval( [[1, 2]] ) == -1';
is [ right_interval( [[1, 4], [2, 2], [3, 4]] ) ], [ -1, 1, -1 ],
    'Example 4: right_interval( [[1, 4], [2, 2], [3, 4]] ) == (-1, 1, -1)';

done_testing;
