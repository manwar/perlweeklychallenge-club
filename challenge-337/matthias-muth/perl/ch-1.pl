#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 337 Task 1: Smaller Than Current
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( frequency );
use List::Util qw( reductions );

sub smaller_than_current( @num1 ) {

    # Count how often every @num1 number appears.
    # This also gives us the distint @num1 numbers in the hash keys.
    my %freq = frequency @num1;

    # Sort the distinct @num1 numbers from lowest to highest.
    my @num1_sorted = sort { $a <=> $b } keys %freq;

    # Create an array of cumulative sums, summing up the frequencies of the
    # numbers in 'sorted' order (not in @num1 order).
    # The sums include all occurrences of each number itself and all lower
    # numbers.
    my @cumulated_sums = reductions { $a + $b } map $freq{$_}, @num1_sorted;

    # Build a hash to map each (distinct) @num1 number to its cumulated sum.
    # Using the fact that the sorted numbers and the cumulated sums are in
    # the same order.
    my %cumulated_sums_lookup =
        map { $num1_sorted[$_] => $cumulated_sums[$_] } 0..$#num1_sorted;

    # Map each @num1 number to its cumulated sum (the 'count of all numbers
    # less than or equal to' result).
    # Correct the sums by -1 to ignore the number itself, as per the updated
    # task examples and clarification by Mohammad Sajid Anwar.
    return map $cumulated_sums_lookup{$_} - 1, @num1;
}


use Test2::V0 qw( -no_srand );

is [ smaller_than_current( 6, 5, 4, 8 ) ], [ 2, 1, 0, 3 ],
    'Example 1: smaller_than_current( 6, 5, 4, 8 ) == (2, 1, 0, 3)';
is [ smaller_than_current( 7, 7, 7, 7 ) ], [ 3, 3, 3, 3 ],
    'Example 2: smaller_than_current( 7, 7, 7, 7 ) == (3, 3, 3, 3)';
is [ smaller_than_current( 5, 4, 3, 2, 1 ) ], [ 4, 3, 2, 1, 0 ],
    'Example 3: smaller_than_current( 5, 4, 3, 2, 1 ) == (4, 3, 2, 1, 0)';
is [ smaller_than_current( -1, 0, 3, -2, 1 ) ], [ 1, 2, 4, 0, 3 ],
    'Example 4: smaller_than_current( -1, 0, 3, -2, 1 ) == (1, 2, 4, 0, 3)';
is [ smaller_than_current( 0, 1, 1, 2, 0 ) ], [ 1, 3, 3, 4, 1 ],
    'Example 5: smaller_than_current( 0, 1, 1, 2, 0 ) == (1, 3, 3, 4, 1)';

done_testing;
