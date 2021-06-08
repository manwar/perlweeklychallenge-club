#!/usr/bin/env perl

# Challenge 116
#
# TASK #2 - Sum of Squares
# Submitted by: Mohammad Meraj Zia
# You are given a number $N >= 10.
#
# Write a script to find out if the given number $N is such that sum of squares
# of all digits is a perfect square. Print 1 if it is otherwise 0.
#
# Example
# Input: $N = 34
# Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
#
# Input: $N = 50
# Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
#
# Input: $N = 52
# Output: 0 as 5^2 + 2^2 => 25 + 4 => 29

use Modern::Perl;

my $N = shift || 0;
say sum_of_squares_is_perfect_square($N) ? 1 : 0;

sub sum_of_squares_is_perfect_square {
    my($num) = @_;
    return 0 if $num < 10;
    my $sum = 0;
    for my $digit (split(//, $num)) {
        $sum += $digit*$digit;
    }
    my $sqrt_int = int(sqrt($sum));
    return $sqrt_int*$sqrt_int==$sum;
}


