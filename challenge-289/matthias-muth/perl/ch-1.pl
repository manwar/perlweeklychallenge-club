#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 289 Task 1: Third Maximum
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( uniq );

sub third_maximum( @ints ) {
    my @sorted_uniq = sort { $b <=> $a } uniq @ints;
    return $sorted_uniq[2] // $sorted_uniq[0];
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is third_maximum( 5, 6, 4, 1 ), 4,
    'Example 1: third_maximum( 5, 6, 4, 1 ) == 4';
is third_maximum( 4, 5 ), 5,
    'Example 2: third_maximum( 4, 5 ) == 5';
is third_maximum( 1, 2, 2, 3 ), 1,
    'Example 3: third_maximum( 1, 2, 2, 3 ) == 1';

done_testing;
