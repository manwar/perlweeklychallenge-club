#!/bin/perl

=pod

The Weekly Challenge - 208
- https://theweeklychallenge.org/blog/perl-weekly-challenge-208

Author: Niels 'PerlBoy' van Dijke

Task 2: Duplicate and Missing
Submitted by: Mohammad S Anwar

You are given an array of integers in sequence with one missing and one duplicate.

Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.

For the sake of this task, let us assume the array contains no more than one duplicate and missing.

=cut

use v5.16;

use common::sense;

use List::MoreUtils qw(slide);

use Test::More;
use Test::Deep qw(cmp_deeply);

sub duplicateAndMissing(@) {
  @_ = sort { $a <=> $b } @_;

  my (@duplicate,@missing);
  slide { 
    if ($a == $b) { push(@duplicate,$a) if ($duplicate[-1] != $b) } 
    elsif ($b - $a > 1) { push(@missing,$a + 1 .. $b - 1) }
  } @_;

  # 'Special' rule to comply to the task:
  push(@missing,$_[-1] + 1) 
    if (scalar(@missing) == 0 && scalar(@duplicate) > 0);

  return [[@duplicate],[@missing]];
}

cmp_deeply(duplicateAndMissing(1,2,2,4),[[2],[3]]);
cmp_deeply(duplicateAndMissing(1,2,3,4),[[],[]]);
cmp_deeply(duplicateAndMissing(1,2,3,3),[[3],[4]]);
cmp_deeply(duplicateAndMissing(1,1,1,3,3,5,6,8,8,9),[[1,3,8],[2,4,7]]);

done_testing;
