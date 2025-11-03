#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 345 Task 1: Peak Positions
#
#       Perl solution by Matthias Muth.
#

use v5.32;      # For chained comparisons.
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub peak_positions( @ints ) {
    my @ridge = ( 0, @ints, 0 );
    return grep $ridge[$_] < $ridge[ $_ + 1 ] > $ridge[ $_ + 2 ], keys @ints;
}

use Test2::V0 qw( -no_srand );

is [ peak_positions( 1, 3, 2 ) ], [ 1 ],
    'Example 1: peak_positions( 1, 3, 2 ) == 1';
is [ peak_positions( 2, 4, 6, 5, 3 ) ], [ 2 ],
    'Example 2: peak_positions( 2, 4, 6, 5, 3 ) == 2';
is [ peak_positions( 1, 2, 3, 2, 4, 1 ) ], [ 2, 4 ],
    'Example 3: peak_positions( 1, 2, 3, 2, 4, 1 ) == (2, 4)';
is [ peak_positions( 5, 3, 1 ) ], [ 0 ],
    'Example 4: peak_positions( 5, 3, 1 ) == 0';
is [ peak_positions( 1, 5, 1, 5, 1, 5, 1 ) ], [ 1, 3, 5 ],
    'Example 5: peak_positions( 1, 5, 1, 5, 1, 5, 1 ) == (1, 3, 5)';

is [ peak_positions( 5 ) ], [ 0 ],
    'Own Example 1: peak_positions( 5 ) == (0)';
is [ peak_positions( 3, 5 ) ], [ 1 ],
    'Own Example 2: peak_positions( 3, 5 ) == (1)';
is [ peak_positions() ], [],
    'Own Example 3: peak_positions() == ()';

done_testing;
