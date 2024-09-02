#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 284 Task 2: Relative Sort
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( frequency );

sub relative_sort( $list1, $list2 ) {
    my %freq1   = frequency( $list1->@* );
    my %exists2 = frequency( $list2->@* );
    return
        map( ( $_ ) x $freq1{$_}, $list2->@* ),
        sort { $a <=> $b } grep ! $exists2{$_}, $list1->@*;
}

use Test2::V0 qw( -no_srand );
is [ relative_sort( [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6] ) ], [ 2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9 ],
    'Example 1: relative_sort( [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6] ) == (2, 2, 1, 4, 3, 3, 5 .. 9)';
is [ relative_sort( [3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2] ) ], [ 1, 3, 3, 3, 2, 2, 4, 4, 6 ],
    'Example 2: relative_sort( [3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2] ) == (1, 3, 3, 3, 2, 2, 4, 4, 6)';
is [ relative_sort( [3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2] ) ], [ 1, 1, 1, 0, 0, 3, 2, 4, 5 ],
    'Example 3: relative_sort( [3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2] ) == (1, 1, 1, 0, 0, 3, 2, 4, 5)';
done_testing;
