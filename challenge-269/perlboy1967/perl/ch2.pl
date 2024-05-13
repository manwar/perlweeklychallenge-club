#!/bin/perl

=pod

The Weekly Challenge - 269
- https://theweeklychallenge.org/blog/perl-weekly-challenge-269

Author: Niels 'PerlBoy' van Dijke

Task 2: Distribute Elements
Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers, @ints.

Write a script to distribute the elements as described below:

1) Put the 1st element of the given array to a new array @arr1.
2) Put the 2nd element of the given array to a new array @arr2.

Once you have one element in each arrays, @arr1 and @arr2, then follow the rule below:

If the last element of the array @arr1 is greater than the last
element of the array @arr2 then add the first element of the
given array to @arr1 otherwise to the array @arr2.

When done distribution, return the concatenated arrays. @arr1 and @arr2.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub distributeElements (@ints) {
  my @a = shift @ints; my @b = shift @ints;
  for (@ints) {
    $a[-1] < $b[-1] ? push(@b,$_) : push(@a,$_);
  }
  return (@a,@b);
}

is([distributeElements(2,1,3,4,5)],
                      [2,3,4,5,1],'Example 2.1');
is([distributeElements(3,2,4)],
                      [3,4,2],'Example 2.2');
is([distributeElements(5,4,3,8)],
                      [5,3,4,8],'Example 2.3');
is([distributeElements(3,2,2,1)],
                      [3,2,1,2],'Own test');
done_testing;
