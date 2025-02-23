#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 309 Task 1: Min Gap
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( min );
use List::MoreUtils qw( slide first_index );

sub min_gap( @ints ) {
    my @gaps = slide { $b - $a } @ints;
    my $smallest_gap = min( @gaps );
    my $index = first_index { $_ == $smallest_gap } @gaps;
    return $ints[ $index + 1 ];
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is min_gap( 2, 8, 10, 11, 15 ), 11,
    'Example 1: min_gap( 2, 8, 10, 11, 15 ) == 11';
is min_gap( 1, 5, 6, 7, 14 ), 6,
    'Example 2: min_gap( 1, 5, 6, 7, 14 ) == 6';
is min_gap( 8, 20, 25, 28 ), 28,
    'Example 3: min_gap( 8, 20, 25, 28 ) == 28';

done_testing;
