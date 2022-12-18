#!/bin/perl

=pod

The Weekly Challenge - 195
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-195/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Most Frequent Even
Submitted by: Mohammad S Anwar

You are given a list of numbers, @list.

Write a script to find most frequent even numbers in the list. In case you
get more than one even numbers then return the smallest even integer. For
all other case, return -1.

=cut

use v5.16;
use common::sense;

use List::Util qw(min max);
use List::MoreUtils qw(frequency);

use Test::More;


sub mostFreqEven {
  my %f = frequency grep { $_ % 2 == 0} @_;
  my $max = max(0,values %f);
  return -1 if ($max == 0);
  return min(grep{$f{$_} == $max}keys %f);
}


for (
  [[1,1,2,6,2],2],
  [[1,3,5,7],-1],
  [[6,4,4,6,1],4]
) {
  is(mostFreqEven(@{$_->[0]}),$_->[1]);
}

done_testing;
