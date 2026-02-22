#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 361 Task 2: Find Celebrity
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub find_celebrity( @party ) {
    my @possible_celebrities =
        grep { sum( $party[$_]->@* ) == 0 } keys @party;
    return @possible_celebrities == 1
        && sum( map $_->[$possible_celebrities[0]], @party ) == @party - 1
        ? $possible_celebrities[0]
        : -1;
}

my $sub_base_name = "find_celebrity";
my @tests = (
    [ "Example 1", [
        [0, 0, 0, 0, 1, 0],  # 0 knows 4
        [0, 0, 0, 0, 1, 0],  # 1 knows 4
        [0, 0, 0, 0, 1, 0],  # 2 knows 4
        [0, 0, 0, 0, 1, 0],  # 3 knows 4
        [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
        [0, 0, 0, 0, 1, 0],  # 5 knows 4
    ], [ 4 ] ],
    [ 'Example 2', [
        [0, 1, 0, 0],  # 0 knows 1
        [0, 0, 1, 0],  # 1 knows 2
        [0, 0, 0, 1],  # 2 knows 3
        [1, 0, 0, 0]   # 3 knows 0
    ], [ -1 ] ],
    [ 'Example 3', [
        [0, 0, 0, 0, 0],  # 0 knows NOBODY
        [1, 0, 0, 0, 0],  # 1 knows 0
        [1, 0, 0, 0, 0],  # 2 knows 0
        [1, 0, 0, 0, 0],  # 3 knows 0
        [1, 0, 0, 0, 0]   # 4 knows 0
    ], [ 0 ] ],
    [ 'Example 4', [
        [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
        [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
        [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
        [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
        [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
        [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
    ], [ 3 ] ],
    [ 'Example 5', [
        [0, 1, 1, 0],  # 0 knows 1 and 2
        [1, 0, 1, 0],  # 1 knows 0 and 2
        [0, 0, 0, 0],  # 2 knows NOBODY
        [0, 0, 0, 0]   # 3 knows NOBODY
    ], [ -1 ] ],
    [ 'Example 6', [
        [0, 0, 1, 1],  # 0 knows 2 and 3
        [1, 0, 0, 0],  # 1 knows 0
        [1, 1, 0, 1],  # 2 knows 0, 1 and 3
        [1, 1, 0, 0]   # 3 knows 0 and 1
    ], [ -1 ] ],
);

use lib '.';
use MultiTest;
run( $sub_base_name, \@tests );
