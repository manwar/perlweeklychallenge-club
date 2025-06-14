#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 325 Task 1: Consecutive One
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Dsay;

use List::Util qw( reductions max );

sub consecutive_one( @binary ) {
    return max( reductions { $b ? ++$a : 0 } @binary );
}

use Test2::V0 qw( -no_srand );

is consecutive_one( 0, 1, 1, 0, 1, 1, 1 ), 3,
    'Example 1: consecutive_one( 0, 1, 1, 0, 1, 1, 1 ) == 3';
is consecutive_one( 0, 0, 0, 0 ), 0,
    'Example 2: consecutive_one( 0, 0, 0, 0 ) == 0';
is consecutive_one( 1, 0, 1, 0, 1, 1 ), 2,
    'Example 3: consecutive_one( 1, 0, 1, 0, 1, 1 ) == 2';

done_testing;
