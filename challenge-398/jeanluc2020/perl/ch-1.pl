#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-398/#TASK1
#
# Task 1: Divisible Average
# =========================
#
# You are given an array of positive integers.
#
# Write a script to return the closest integer to the mean value of all even
# integers that are divisible by 3. If none is divisible, return 0.
#
## Example 1
##
## Input: @arr = (18, 5, 7, 11)
## Output: 18
##
## 18 is the only even number and divisible by 3.
## Average: 18 / 1 = 18.
#
## Example 2
##
## Input: @arr = (6, 12, 18, 24, 30, 40)
## Output: 18
##
## The qualifying numbers are 6, 12, 18, 24, and 30.
## Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18
#
## Example 3
##
## Input: @arr = (3, 9, 15, 21, 27)
## Output: 0
##
## None of the elements are even.
## Since no elements qualify, return 0.
#
## Example 4
##
## Input: @arr = (6, 12, 14, 20)
## Output: 9
##
## The qualifying numbers are 6 and 12.
## Average: (6 + 12) / 2 = 9.
#
## Example 5
##
## Input: @arr = (6, 6, 6, 12, 12)
## Output: 8
##
## All five numbers are even and divisible by 3.
## Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8
#
############################################################
##
## discussion
##
############################################################
#
# First, we collect all even numbers that are divisible by 3,
# which are exactly all numbers divisible by 6. Then we calculate
# their average, add 0.5 and take the integer value of that.
#
use v5.36;
use List::Util qw(sum);

sub divisible_average(@arr) {
    say "Input: (" . join(", ", @arr) . ")";
    my @divisible = grep { $_ % 6 == 0 } @arr;
    return say "Output: 0" unless @divisible;
    my $count = scalar(@divisible);
    my $avg = int( sum(@divisible) / $count + 0.5);
    say "Output: $avg";
}


divisible_average(18, 5, 7, 11);
divisible_average(6, 12, 18, 24, 30, 40);
divisible_average(3, 9, 15, 21, 27);
divisible_average(6, 12, 14, 20);
divisible_average(6, 6, 6, 12, 12);
