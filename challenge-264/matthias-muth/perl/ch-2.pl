#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 264 Task 2: Target Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub target_array( $source, $indices ) {
    my @results;
    splice @results, $indices->[$_], 0, $source->[$_]
	for 0..$indices->$#*;
    return @results;
}

use Test2::V0 qw( -no_srand );
is [ target_array( [0 .. 4], [0, 1, 2, 2, 1] ) ], [ 0, 4, 1, 3, 2 ],
    'Example 1: target_array( [0 .. 4], [0, 1, 2, 2, 1] ) == (0, 4, 1, 3, 2)';
is [ target_array( [1 .. 4, 0], [0 .. 3, 0] ) ], [ 0, 1, 2, 3, 4 ],
    'Example 2: target_array( [1 .. 4, 0], [0 .. 3, 0] ) == (0 .. 4)';
is [ target_array( [1], [0] ) ], [ 1 ],
    'Example 3: target_array( [1], [0] ) == 1';
done_testing;
