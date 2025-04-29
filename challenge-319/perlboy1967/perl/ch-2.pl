#!/bin/perl

=pod

The Weekly Challenge - 319
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-319#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Minimum Common
Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers.

Write a script to return the minimum integer common to both arrays.
If none found return -1.

=cut

use v5.32;
use common::sense;
use Test2::V0 qw(-no_srand);

use List::Util qw(min max);
use List::MoreUtils qw(frequency);

sub minimumCommon  (\@\@) {
  my ($ar1,$ar2) = @_;
  my %f = frequency(@$ar1,@$ar2);
  my $max = max(grep { $_ > 1 } values %f);
  return if !defined $max;
  return min(grep { $f{$_} == $max } keys %f);
}

is(minimumCommon(@{[1,2,3,4]},@{[3,4,5,6]}),3,'Example 1');
is(minimumCommon(@{[1,2,3]},@{[2,4]}),2,'Example 2');
is(minimumCommon(@{[1,2,3,4]},@{[5,6,7,8]}),undef,'Example 3');
is(minimumCommon(@{[4,2,1,1]},@{[1,1,2,4]}),1,'Own Example');

done_testing;
