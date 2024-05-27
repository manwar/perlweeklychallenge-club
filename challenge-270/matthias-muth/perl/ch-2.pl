#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 270 Task 2: Distribute Elements
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max sum );

sub distribute_elements( $ints, $x, $y ) {
    # Flip things around, creating an array of what we need to
    # bring down to zero instead of moving everything up to the largest number.
    #
    my $max = max( $ints->@* );
    my @to_do = grep $_ != 0, map $max - $_, $ints->@*;
    my $sum_to_do = sum( @to_do );

    # If it is more costly to decrement two numbers using level 2 decrements
    # than two times a level 1 decrement, we do everything with level 1.
    return $sum_to_do * $x
        if 2 * $x <= $y;

    # If the largest number is greater than everything else together
    # (without the largest number itself), we can do level 2 decrements
    # to decrease the largest number and any one of the other numbers
    # until there are no others anymore.
    # What is left of the largest number after that, we need to remove using
    # level 1 single decrements.
    # As we know everything in advance, we can compute the total cost even
    # without actually doing the operations.
    my $largest = max( @to_do );
    my $rest = $sum_to_do - $largest;
    return $rest * $y + ( $largest - $rest ) * $x
        if $largest > $rest;

    # Here, we know that we have enough points in the other numbers to completely
    # remove the largest one. I *ASSUME* that in this case, we *ALWAYS* can
    # repeatedly decrement the largest and second largest of the remaining
    # number, down to having nothing at all any more, or at most one single
    # leftover 1.
    # Using this assumption, we can again compute the cost without
    # really looping through the decrements.
    return int( $sum_to_do / 2 ) * $y + ( $sum_to_do % 2 ) * $x;
}

use Test2::V0 qw( -no_srand );
is distribute_elements( [5, 4, 1], 100, 1 ), 301,
    'Test 1: distribute_elements( [5, 4, 1], 100, 1 ) == 301';
is distribute_elements( [4, 1], 3, 2 ), 9,
    'Example 1: distribute_elements( [4, 1], 3, 2 ) == 9';
is distribute_elements( [2, 3, 3, 3, 5], 2, 1 ), 6,
    'Example 2: distribute_elements( [2, 3, 3, 3, 5], 2, 1 ) == 6';
is distribute_elements( [ 1, 4, 4, 4, 6 ], 100, 1 ), 105,
    'Test 2: distribute_elements( [ 1, 4, 4, 4, 6 ], 100, 1 ) == 105';

done_testing;
