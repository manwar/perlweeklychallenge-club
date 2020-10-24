#!/usr/bin/perl

=pod
TASK #2 › Flip Array
Submitted by: Mohammad S Anwar

You are given an array @A of positive numbers.

Write a script to flip the sign of some members of the given array so that the sum of the all members is minimum non-negative.

Given an array of positive elements, you have to flip the sign of some of its elements such that the resultant sum of the elements of array should be minimum non-negative(as close to zero as possible). Return the minimum no. of elements whose sign needs to be flipped such that the resultant sum is minimum non-negative.
Example 1:

Input: @A = (3, 10, 8)
Output: 1

Explanation:

Flipping the sign of just one element 10 gives the result 1 i.e. (3) + (-10) + (8) = 1

Example 2:

Input: @A = (12, 2, 10)
Output: 1

Explanation:

Flipping the sign of just one element 12 gives the result 0 i.e. (-12) + (2) + (10) = 0
=cut

use v5.30;
use warnings;
use experimental 'smartmatch';

use Test::More tests => 4;

sub test {
    $_ = `perl ch-2.pl @_`;
    chomp;
    return $_;
}

# Tests.
is &test( 3,   10, 8 ),   1;
is &test( 12,  2,  10 ),  1;
is &test( -12, -2, -10 ), 1;

# The following series has two possible solutions: 2 and 5.
ok &test( 1, 2, 3, 4, 5, 6, 9 ) ~~ [ 2, 5 ];
