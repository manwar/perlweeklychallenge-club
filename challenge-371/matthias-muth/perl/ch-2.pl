#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 371 Task 2: Subset Equilibrium
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Algorithm::Combinatorics qw( subsets );
use List::Util qw( sum );

sub subset_equilibrium( @nums ) {
    # Pre-compute the difference between each element and its position
    # (using 1-based position numbers).
    # If the sum of elements is equal to the sum of their positions,
    # the sum of these differences must be zero.
    # This will save us half of the additions.
    my @diffs = map $nums[$_] - ( $_ + 1 ), keys @nums;
    my @results;
    for my $subset_size ( 2 .. @nums - 1 ) {
        my $iter = subsets( [ keys @nums ], $subset_size );
        while ( my $indices = $iter->next ) {
            push @results, [ map $nums[$_], $indices->@* ]
                if sum( map $diffs[$_], $indices->@* ) == 0;
        }
    }
    return @results;
}

use Test2::V0 qw( -no_srand );

is [ subset_equilibrium( 2, 1, 4, 3 ) ],
    bag { item $_ for [2, 1], [1, 4], [4, 3], [2, 3]; end },
    'Example 1: subset_equilibrium( 2, 1, 4, 3 )'
        . ' => ([2, 1], [1, 4], [4, 3], [2, 3])';
is [ subset_equilibrium( 3, 0, 3, 0 ) ],
    bag { item $_ for [3, 0], [3, 0, 3]; end },
    'Example 2: subset_equilibrium( 3, 0, 3, 0 )'
        . ' => ([3, 0], [3, 0, 3])';
is [ subset_equilibrium( 5, 1, 1, 1 ) ],
    [ [5, 1, 1] ],
    'Example 3: subset_equilibrium( 5, 1, 1, 1 ) => ([5, 1, 1])';
is [ subset_equilibrium( 3, -1, 4, 2 ) ],
    bag { item $_ for [3, 2], [3, -1, 4]; end },
    'Example 4: subset_equilibrium( 3, -1, 4, 2 )  => ([3, 2], [3, -1, 4])';
is [ subset_equilibrium( 10, 20, 30, 40 ) ],
    [],
    'Example 5: subset_equilibrium( 10, 20, 30, 40 ) => ()';

done_testing;
