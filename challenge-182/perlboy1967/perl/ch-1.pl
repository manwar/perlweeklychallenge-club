#!/bin/perl

=pod

The Weekly Challenge - 182
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-182/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Index
Submitted by: Mohammad S Anwar

You are given a list of integers.

Write a script to find the index of the first biggest number in the list.

=cut

use v5.16;
use warnings;

use List::Util qw(max);
use List::MoreUtils qw(first_index);

use Test::More;


sub maxFirstIndex (@) {
  my $m = max(@_);
  first_index { $_ == $m } @_;
}


is(maxFirstIndex(5,2,9,1,7,6),2);
is(maxFirstIndex(4,2,3,1,5,0),4);
is(maxFirstIndex(2,4,6,8,3,5,7),3);

my @l = (1 .. 10);
is(maxFirstIndex(@l),9);
is(maxFirstIndex(reverse @l),0);

done_testing();
