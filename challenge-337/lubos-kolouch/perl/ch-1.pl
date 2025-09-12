#!/usr/bin/env perl
use strict;
use warnings;

# Task 1: Smaller Than Current
#
# You are given an array of numbers, @num1.
#
# Write a script to return an array, @num2, where $num2[i] is the count of all numbers less than or equal to $num1[i] in the array, excluding the number itself.
#
# Example 1
# Input: @num1 = (6, 5, 4, 8)
# Output: (2, 1, 0, 3)
#
# Example 2
# Input: @num1 = (7, 7, 7, 7)
# Output: (3, 3, 3, 3)
#
# Example 3
# Input: @num1 = (5, 4, 3, 2, 1)
# Output: (4, 3, 2, 1, 0)

sub smaller_than_current {
    my (@nums) = @_;
    my @result;

    for my $i ( 0 .. $#nums ) {
        my $count = 0;
        for my $j ( 0 .. $#nums ) {
            if ( $i == $j ) {
                next;
            }
            if ( $nums[$j] <= $nums[$i] ) {
                $count++;
            }
        }
        push @result, $count;
    }

    return @result;
}

use Test::More;

is_deeply( [ smaller_than_current( 6, 5, 4, 8 ) ],      [ 2, 1, 0, 3 ],    'Example 1' );
is_deeply( [ smaller_than_current( 7, 7, 7, 7 ) ],      [ 3, 3, 3, 3 ],    'Example 2' );
is_deeply( [ smaller_than_current( 5, 4, 3, 2, 1 ) ],   [ 4, 3, 2, 1, 0 ], 'Example 3' );
is_deeply( [ smaller_than_current( -1, 0, 3, -2, 1 ) ], [ 1, 2, 4, 0, 3 ], 'Example 4' );
is_deeply( [ smaller_than_current( 0, 1, 1, 2, 0 ) ],   [ 1, 3, 3, 4, 1 ], 'Example 5' );

done_testing();
