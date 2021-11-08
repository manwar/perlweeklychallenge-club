#!/usr/bin/perl

# Perl Weekly Challenge - 127
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-127/#TASK1
#
# Task 1 - Disjoint Sets
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

is(areDisjointSets([1,2,3],[2,3,4]),0);
is(areDisjointSets([1,2,3],[4,5,6]),1);

done_testing;


sub areDisjointSets {
  my ($ar1,$ar2) = @_;

  my %h = map +($_,1),@$ar1;

  foreach my $i (@$ar2) {
    return 0 if exists $h{$i};
  }

  return 1;
}
