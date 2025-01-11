#!/bin/perl

=pod

The Weekly Challenge - 303
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-303#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: 3-digits Even
Submitted by: Mohammad Sajid Anwar

You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using
the integers in the given list.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

use Algorithm::Combinatorics qw(variations);
use List::MoreUtils qw(uniq);

no warnings qw(experimental::signatures);
sub threeDigitsEven (@ints) {
  [ 
    sort { $a <=> $b } 
    uniq 
    grep { length($_) == 3 && $_ % 2 == 0 } 
    map { int($$_[0].$$_[1].$$_[2]) } variations(\@ints,3) 
  ];
}

is(threeDigitsEven(2,1,3,0),
   [102,120,130,132,210,230,302,310,312,320],'Example 1');
is(threeDigitsEven(2,2,8,8,2),
   [222, 228, 282, 288, 822, 828, 882],'Example 2');

done_testing;
