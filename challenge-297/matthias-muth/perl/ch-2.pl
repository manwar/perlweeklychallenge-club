#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 297 Task 2: Semi-Ordered Permutation
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub semi_ordered_permutation( @ints ) {
    my $n = scalar @ints;
    my ( $one_index, $n_index );
    for my $index ( keys @ints ) {
        $one_index = $index if $ints[$index] == 1;
        $n_index   = $index if $ints[$index] == $n;
        last if defined $one_index && defined $n_index;
    }
    my $moves_for_one = $one_index;
    my $moves_for_n   = ( $n - 1 ) - $n_index;
    return $moves_for_one + $moves_for_n
        - ( $one_index > $n_index ? 1 : 0 );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is semi_ordered_permutation( 2, 1, 4, 3 ), 2,
    'Example 1: semi_ordered_permutation( 2, 1, 4, 3 ) == 2';
is semi_ordered_permutation( 2, 4, 1, 3 ), 3,
    'Example 2: semi_ordered_permutation( 2, 4, 1, 3 ) == 3';
is semi_ordered_permutation( 1, 3, 2, 4, 5 ), 0,
    'Example 3: semi_ordered_permutation( 1, 3, 2, 4, 5 ) == 0';
is semi_ordered_permutation( 2, 5, 4, 1, 3 ), 5,
    'Extra 1: semi_ordered_permutation( 2, 5, 4, 1, 3 ) == 5';

done_testing;
