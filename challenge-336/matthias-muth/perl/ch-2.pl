#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 336 Task 2: Final Score
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub final_score( @scores ) {
    my @list;
    for ( @scores ) {
        /^C$/    and do { pop @list;                         next };
        /^D$/    and do { push @list, 2 * $list[-1];         next };
        /^\+$/   and do { push @list, $list[-2] + $list[-1]; next };
        /-?\d+$/ and do { push @list, $&;                    next };
    }
    return sum( @list );
}

use Test2::V0 qw( -no_srand );

is final_score( 5, 2, "C", "D", "+" ), 30,
    'Example 1: final_score( 5, 2, "C", "D", "+" ) == 30';
is final_score( 5, -2, 4, "C", "D", 9, "+", "+" ), 27,
    'Example 2: final_score( 5, -2, 4, "C", "D", 9, "+", "+" ) == 27';
is final_score( 7, "D", "D", "C", "+", 3 ), 45,
    'Example 3: final_score( 7, "D", "D", "C", "+", 3 ) == 45';
is final_score( -5, -10, "+", "D", "C", "+" ), -55,
    'Example 4: final_score( -5, -10, "+", "D", "C", "+" ) == -55';
is final_score( 3, 6, "+", "D", "C", 8, "+", "D", -2, "C", "+" ), 128,
    'Example 5: final_score( 3, 6, "+", "D", "C", 8, "+", "D", -2, "C", "+" ) == 128';

done_testing;
