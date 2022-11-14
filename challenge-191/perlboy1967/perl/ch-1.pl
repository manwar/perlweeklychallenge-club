#!/bin/perl

=pod

The Weekly Challenge - 191
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-191/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Twice Largest
Submitted by: Mohammad S Anwar

You are given list of integers, @list.

Write a script to find out whether the largest item in the list is at least twice
as large as each of the other items.

=cut

use v5.16;
use warnings;

use Test::More;
use List::Util qw(max);
use List::MoreUtils qw(all none firstidx);


sub twiceLargest {
  return -1 if @_ < 2;

  my $max = max(@_);

  return ((firstidx { $max < ($_ << 1) } grep { $_ != $max } @_) == -1 ? 1 : -1);
}


is(twiceLargest(1,2,3,4),-1);
is(twiceLargest(1,2,0,5),1);
is(twiceLargest(2,6,3,1),1);
is(twiceLargest(1),-1);
is(twiceLargest(1,2),1);
is(twiceLargest(),-1);

done_testing;
