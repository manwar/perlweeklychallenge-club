#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 263 Task 2: Merge Items
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Data::Dump qw( pp );

sub merge_items( $items1, $items2 ) {
    #my %counts;
    my %counts = map $_->@*, $items1->@*;
    say pp \%counts;
    $counts{$_->[0]} += $_->[1]
	for $items1->@*, $items2->@*;
    return [ map [ $_, $counts{$_} ], sort keys %counts ];

}

use Test2::V0 qw( -no_srand );
is merge_items( [[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]] ), [[1, 4], [2, 3], [3, 2]],
    'Example 1: merge_items( [[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]] ) == [[1, 4], [2, 3], [3, 2]]';
is merge_items( [[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]] ), [[1, 8], [2, 3], [3, 3]],
    'Example 2: merge_items( [[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]] ) == [[1, 8], [2, 3], [3, 3]]';
is merge_items( [[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]] ), [[1, 1], [2, 9], [3, 3]],
    'Example 3: merge_items( [[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]] ) == [[1, 1], [2, 9], [3, 3]]';
done_testing;
