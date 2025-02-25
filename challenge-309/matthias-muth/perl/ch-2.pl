#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 309 Task 2: Min Diff
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( min );
use List::MoreUtils qw( slide );

sub min_diff( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    my @gaps = slide { $b - $a } @ints;
    return min( @gaps );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is min_diff( 1, 5, 8, 9 ), 1,
    'Example 1: min_diff( 1, 5, 8, 9 ) == 1';
is min_diff( 9, 4, 1, 7 ), 2,
    'Example 2: min_diff( 9, 4, 1, 7 ) == 2';

done_testing;
