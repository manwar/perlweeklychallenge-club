#!/bin/perl

=pod

The Weekly Challenge - 204
- https://theweeklychallenge.org/blog/perl-weekly-challenge-204/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Monotonic Array
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.

|| An array is Monotonic if it is either monotone increasing or decreasing.

Monotone increasing: for i <= j , nums[i] <= nums[j]
Monotone decreasing: for i <= j , nums[i] >= nums[j]

=cut

use v5.16;
use common::sense;

use Test::More;

sub isMonotonicArray (@) {
  return if (scalar @_ < 2);

  my @arr = @_;
  my $trend = 0;

  my $i = shift(@arr);
  do {
    my $j = shift(@arr);
    $trend = ($j == $i ? 0 : $i < $j ? 1 : -1) if ($trend == 0);
    return 0 if ($trend and ($j - $i)/$trend < 0);
    $i = $j;
  } while (@arr);

  return 1;
}

is(isMonotonicArray(1,2,2,3),1);
is(isMonotonicArray(1,3,2),0);
is(isMonotonicArray(6,5,5,4),1);
is(isMonotonicArray(1,1,2,2),1);
is(isMonotonicArray(1,1),1);

done_testing;
