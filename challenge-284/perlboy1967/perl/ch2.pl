#!/bin/perl

=pod

The Weekly Challenge - 284
- L<https://theweeklychallenge.org/blog/perl-weekly-challenge-284>

Author: Niels 'PerlBoy' van Dijke

Task 2: Relative Sort
Submitted by: Mohammad Sajid Anwar

You are given two list of integers, @list1 and @list2. The elements in the @list2 are
distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order of items
in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed
at the end of @list1 in ascending order.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::MoreUtils qw(indexes);

sub relativeSort :prototype(\@\@) ($arL1,$arL2) {
  my @r;
  my @l = @$arL1;
  for my $l2 (@$arL2) {
    push(@r,splice(@l,$_,1)) for (reverse sort {$a <=> $b} indexes {$_ == $l2} @l);
  }
  push(@r,sort {$a <=> $b} @l);
  [@r];
}

is(relativeSort(@{[2,3,9,3,1,4,6,7,2,8,5]},@{[2,1,4,3,5,6]}),
                [2,2,1,4,3,3,5,6,7,8,9],'Example 1');
is(relativeSort(@{[3,3,4,6,2,4,2,1,3]},@{[1,3,2]}),
                [1,3,3,3,2,2,4,4,6],'Example 2');
is(relativeSort(@{[3,0,5,0,2,1,4,1,1]},@{[1,0,3,2]}),
                [1,1,1,0,0,3,2,4,5],'Example 3');

done_testing;

