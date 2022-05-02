#!/bin/perl

=pod

The Weekly Challenge - 163
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-163/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Sum Bitwise Operator
Submitted by: Mohammad S Anwar

You are given list positive numbers, @n.

Write script to calculate the sum of bitwise & operator for all unique pairs.

=cut

use v5.16;

use List::Util qw(sum);
use List::MoreUtils qw(singleton duplicates);
use Algorithm::Combinatorics qw(combinations);
use Test::More;

is (andSum(1,2,3), 3);
is (andSum(2,3,4), 2);

is (andSum(2,2), 2);
is (andSum(2,2,2), 2);
is (andSum(1), 0);

done_testing();


sub andSum {
  return 0 if @_ < 2;
  return sum map{$_->[0]&$_->[1]}combinations([singleton(@_),map{($_)x2}duplicates(@_)],2);
}
