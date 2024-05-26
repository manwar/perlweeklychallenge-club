#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 270 Task 1: Special Positions
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( any zip );

sub special_positions( $matrix ) {
    # Extract only those rows that have exactly one non-zero element.
    my @single_element_rows =
        grep { ( scalar grep $_ != 0, $_->@* ) == 1 }
            $matrix->@*;
    # Determine the indexes of all columns that have exactly one
    # non-zero element, after flipping the matrix to get column
    # vectors.
    my @columns = zip $matrix->@*;
    my @single_element_columns_indexes =
        grep { ( scalar grep $_ != 0, $columns[$_]->@* ) == 1 }
            0..$#columns;
    # Return the count of those rows where we find a '1' in one of the
    # single-element columns. If we find one, we are sure it will be
    # the only one, since the rows that we look at all have one single
    # element only.
    return scalar grep {
        my $row = $_;
        any { $row->[$_] == 1 } @single_element_columns_indexes
    } @single_element_rows;
}

use Test2::V0 qw( -no_srand );
is special_positions( [[0, 0, 0], [0, 0, 0], [0, 0, 0]] ), 0,
    'Test 1: special_positions( [[0, 0, 0], [0, 0, 0], [0, 0, 0]] ) == 0';
is special_positions( [[1, 0, 0], [0, 0, 1], [1, 0, 0]] ), 1,
    'Example 1: special_positions( [[1, 0, 0], [0, 0, 1], [1, 0, 0]] ) == 1';
is special_positions( [[1, 0, 0], [0, 1, 0], [0, 0, 1]] ), 3,
    'Example 2: special_positions( [[1, 0, 0], [0, 1, 0], [0, 0, 1]] ) == 3';
done_testing;
