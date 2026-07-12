#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 381 Task 1: Same Row Column
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

sub same_row_column( $matrix ) {
    my $n = scalar $matrix->@*;
    my ( @row_presences, @column_presences );
    for my $r ( keys $matrix->@* ) {
        for my $c ( keys $matrix->[$r]->@* ) {
            my $value = $matrix->[$r][$c];
            return false
                unless 0 < $value <= $n
                    && ! $row_presences[$r][$value]++
                    && ! $column_presences[$c][$value]++
        }
    }
    return true;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [[[1 .. 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]], T ],
    [ "Example 2", [[[1]]], T ],
    [ "Example 3", [[[1, 2, 5], [5, 1, 2], [2, 5, 1]]], F ],
    [ "Example 4", [[[1, 2, 3], [1, 2, 3], [1, 2, 3]]], F ],
    [ "Example 5", [[[1, 2, 3], [3, 1, 2], [3, 2, 1]]], F ],
);

is same_row_column( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
