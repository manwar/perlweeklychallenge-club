#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-361#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Find Celebrity
Submitted by: Mohammad Sajid Anwar

You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

||  A celebrity is someone, everyone knows and knows nobody.


=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::AllUtils qw(all);

sub findCelebrity ($ar) {
  my $i;
  my @celeb = grep /\d/, map { $i++; (all { $_ == 0 } @$_) ? $i-1 : '' } @$ar;
  return (@celeb == 1 ? $celeb[0] : -1);
}

is(findCelebrity(
  [
    [0, 0, 0, 0, 1, 0],  # 0 knows 4
    [0, 0, 0, 0, 1, 0],  # 1 knows 4
    [0, 0, 0, 0, 1, 0],  # 2 knows 4
    [0, 0, 0, 0, 1, 0],  # 3 knows 4
    [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
    [0, 0, 0, 0, 1, 0],  # 5 knows 4);
  ]),4,'Example 1');
is(findCelebrity(
  [
    [ 0, 1, 1], # 0 knows 1 & 2
    [ 0, 0, 0], # 1 knows NOBODY
    [ 0, 0, 0], # 2 knows NOBODY
  ]),-1,'Own example');

done_testing;
