#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/#TASK2
#
# Task 2: Big and Little Omega
# ============================
#
# You are given a positive integer $number and a mode flag $mode. If the mode
# flag is zero, calculate little omega (the count of all distinct prime factors
# of that number). If it is one, calculate big omega (the count of all prime
# factors including duplicates).
#
## Example 1
##
## Input: $number = 100061
##        $mode = 0
## Output: 3
##
## Prime factors are 13, 43, 179. Count is 3.
#
## Example 2
##
## Input: $number = 971088
##        $mode = 0
## Output: 3
##
## Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.
#
## Example 3
##
## Input: $number = 63640
##        $mode = 1
## Output: 6
##
## Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.
#
## Example 4
##
## Input: $number = 988841
##        $mode = 1
## Output: 2
#
## Example 5
##
## Input: $number = 211529
##        $mode = 0
## Output: 2
#
############################################################
##
## discussion
##
############################################################
#
# First, we create the list of prime factors. Then, dependent on
# $mode, we either keep it as is or filter it through List::Util's
# uniq() to get the list of distinct prime factors. In the end, we
# just need to get the number of elements of the resulting array.

use v5.36;
use List::Util qw(uniq);

big_and_little_omega(100061,0);
big_and_little_omega(971088,0);
big_and_little_omega(63640,1);
big_and_little_omega(988841,1);
big_and_little_omega(211529,0);

sub big_and_little_omega($number, $mode) {
    say "Input: $number, $mode";
    my @factors = prime_factors($number);
    @factors = uniq(@factors) unless $mode;
    say "Output: " . scalar(@factors);
}

sub prime_factors($number) {
    my @result = ();
    foreach my $i (2..$number-1) {
        if($number % $i == 0) {
            push @result, $i;
            push @result, prime_factors($number / $i);
            return @result;
        }
    }
    push @result, $number;
    return @result;
}

