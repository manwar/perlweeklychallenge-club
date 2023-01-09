#!/bin/perl

=pod

The Weekly Challenge - 199
- https://theweeklychallenge.org/blog/perl-weekly-challenge-199/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Good Pairs
Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total count of Good Pairs.

|| A pair (i, j) is called good if list[i] == list[j] and i < j.

=cut

use v5.16;
use common::sense;


use Test::More;
use Test::Deep qw(cmp_deeply);


sub goodPairs {
  my $ar = [];
  for my $i (0 .. scalar(@_) - 1) {
    for my $j ($i + 1 .. scalar(@_) - 1) {
      push(@$ar,[$i,$j]) if ($_[$i] == $_[$j] and $i < $j);
    }
  }
  return $ar;
}


cmp_deeply(goodPairs(1,2,3,1,1,3),[[0,3],[0,4],[2,5],[3,4]]);
cmp_deeply(goodPairs(1,2,3),[]);
cmp_deeply(goodPairs(1,1,1,1),[[0,1],[0,2],[0,3],[1,2],[1,3],[2,3]]);

done_testing;
