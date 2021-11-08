#!/usr/bin/perl

# Perl Weekly Challenge - 127
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-127/#TASK2
#
# Task 2 - Conflict Intervals
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;
use Test::Deep;

cmp_deeply (conflictIntervals([1,4],[3,5],[6,8],[12,13],[3,20]),[[3,5],[3,20]]);
cmp_deeply (conflictIntervals([3,4],[5,7],[6,9],[10,12],[13,15]),[[6,9]]);
cmp_deeply (conflictIntervals([1,4],[6,8],[5,6]),[[5,6]]);

done_testing;


sub conflictIntervals {

  my @i; my @o;

  foreach my $ar (@_) {
    if (!grep { ($ar->[0] >= $_->[0] and $ar->[0] <= $_->[1]) or 
                ($ar->[1] >= $_->[0] and $ar->[1] <= $_->[1])} @i) {
      push(@i,$ar);
    } else {
      push(@o,$ar);
    }
  }

  return [@o];
}
