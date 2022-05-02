#!/bin/perl

=pod

The Weekly Challenge - 163
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-163/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Summations
Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n.

Write a script to find out the summations as described below.
Example

Input: @n = (1, 2, 3, 4, 5)
Output: 42

    1 2 3  4  5
      2 5  9 14
        5 14 28
          14 42
             42

The nth Row starts with the second element of the (n-1)th row.
The following element is sum of all elements except first element of previous row.
You stop once you have just one element in the row.

=cut

use v5.16;

use Test::More;
use List::Util qw(sum);
use Data::Printer;

is (summation(1,2,3,4,5), 42);
is (summation(1,3,5,7,9), 70);

done_testing();

sub summation {
  my (@d) = @_;

  while (@d > 1) {
    my @t = ((splice(@d,0,2))[1]);
    push(@t,$t[-1] + shift(@d)) while (@d);
    @d = @t;
  }

  return $d[0];
} 
