#!/bin/perl

=pod

The Weekly Challenge - 197
- https://theweeklychallenge.org/blog/perl-weekly-challenge-197/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Gap
Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total pairs in the sorted list where 2 consecutive
elements has the max gap. If the list contains less then 2 elements then return 0.

=cut

use v5.16;
use common::sense;

use List::Util qw(max);
use List::MoreUtils qw(slide);

use Test::More;


sub maxGap {
  return 0 if (scalar @_ < 2);
 
  my @l = sort { $a <=> $b } @_;

  # Find maxGap size
  my $maxGap = max slide { $b - $a } @l;

  # Find and count maxGap pairs
  scalar grep { $_ } slide { $b - $a == $maxGap } @l;
}


is(maxGap(2,5,8,1),2);
is(maxGap(3),0);
is(maxGap(1,1,2,2,3,3),2);

done_testing;
