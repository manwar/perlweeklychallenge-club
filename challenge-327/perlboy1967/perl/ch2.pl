#!/bin/perl

=pod

The Weekly Challenge - 327
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-327#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: MAD
Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with minimum absolute difference
(MAD) of any two elements.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(min);

sub getMad (@ints) {
  my %ad;
  for my $pair (combinations(\@ints,2)) {
    my ($lo,$hi) = sort { $a <=> $b } @$pair;
    push(@{$ad{$hi - $lo}},[$lo,$hi]);
  }
  sort {$$a[0] <=> $$b[0]} @{$ad{min keys %ad}};
}

is([getMad(4,1,2,3)],[[1,2],[2,3],[3,4]],'Example 1');
is([getMad(1,3,7,11,15)],[[1,3]],'Example 2');
is([getMad(1,5,3,8)],[[1,3],[3,5]],'Example 3');

done_testing;
