#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 319 Task 2: Minimum Common
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( first );

sub minimum_common_using_sort( $array_1, $array_2 ) {
    my %is_in_array_2 = map { ( $_ => 1 ) } $array_2->@*;
    return
        ( first { $is_in_array_2{$_} }
            sort { $a <=> $b } $array_1->@* )
        // -1;
}

use List::Util qw( min );

sub minimum_common( $array_1, $array_2 ) {
    my %is_in_array_2 = map { ( $_ => 1 ) } $array_2->@*;
    return min( grep $is_in_array_2{$_}, $array_1->@* ) // -1;
}

use Test2::V0 qw( -no_srand );

is minimum_common( [1 .. 4], [3 .. 6] ), 3,
    'Example 1: minimum_common( [1 .. 4], [3 .. 6] ) == 3';
is minimum_common( [1, 2, 3], [2, 4] ), 2,
    'Example 2: minimum_common( [1, 2, 3], [2, 4] ) == 2';
is minimum_common( [1 .. 4], [5 .. 8] ), -1,
    'Example 3: minimum_common( [1 .. 4], [5 .. 8] ) == -1';

done_testing;
