#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 271 Task 1: Maximum Ones
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max first );

sub maximum_ones( $matrix ) {
    # Get the number of ones for each row.
    my @n_ones = map scalar grep( $_ == 1, $_->@* ), $matrix->@*;

    # Find the highest number of ones.
    my $max_n_ones = max( @n_ones );

    # Return the first row number (1-based, not 0-based!)
    # that has that highest number of ones.
    return 1 + first { $n_ones[$_] == $max_n_ones } 0..$#n_ones;
}

use Test2::V0 qw( -no_srand );
is maximum_ones( [[0, 1], [1, 0]] ), 1,
    'Example 1: maximum_ones( [[0, 1], [1, 0]] ) == 1';
is maximum_ones( [[0, 0, 0], [1, 0, 1]] ), 2,
    'Example 2: maximum_ones( [[0, 0, 0], [1, 0, 1]] ) == 2';
is maximum_ones( [[0, 0], [1, 1], [0, 0]] ), 2,
    'Example 3: maximum_ones( [[0, 0], [1, 1], [0, 0]] ) == 2';
done_testing;
