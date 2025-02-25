#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 302 Task 2: Step by Step
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( min reductions );

sub step_by_step( @ints ) {
    return 1 - min( 0, reductions { $a + $b } @ints );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is step_by_step( -3, 2, -3, 4, 2 ), 5,
    'Example 1: step_by_step( -3, 2, -3, 4, 2 ) == 5';
is step_by_step( 1, 2 ), 1,
    'Example 2: step_by_step( 1, 2 ) == 1';
is step_by_step( 1, -2, -3 ), 5,
    'Example 3: step_by_step( 1, -2, -3 ) == 5';

done_testing;
