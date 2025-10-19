#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 343 Task 1: Zero Friend
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( min );

sub zero_friend( @nums ) {
    return min( map abs, @nums );
}

use Test2::V0 qw( -no_srand );

is zero_friend( 4, 2, -1, 3, -2 ), 1,
    'Example 1: zero_friend( 4, 2, -1, 3, -2 ) == 1';
is zero_friend( -5, 5, -3, 3, -1, 1 ), 1,
    'Example 2: zero_friend( -5, 5, -3, 3, -1, 1 ) == 1';
is zero_friend( 7, -3, 0, 2, -8 ), 0,
    'Example 3: zero_friend( 7, -3, 0, 2, -8 ) == 0';
is zero_friend( -2, -5, -1, -8 ), 1,
    'Example 4: zero_friend( -2, -5, -1, -8 ) == 1';
is zero_friend( -2, 2, -4, 4, -1, 1 ), 1,
    'Example 5: zero_friend( -2, 2, -4, 4, -1, 1 ) == 1';

done_testing;
