#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-345#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Last Visitor
Submitted by: Mohammad Sajid Anwar

You are given an integer array @ints where each element is either a positive integer or -1.

We process the array from left to right while maintaining two lists:

|| @seen: stores previously seen positive integers (newest at the front)
|| @ans: stores the answers for each -1

Rules:

If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:

Let $x be how many -1s in a row we’ve seen before this one.

If $x < len(@seen) -> append seen[x] to @ans

Else -> append -1 to @ans

At the end, return @ans.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub lastVisitor  (@ints) {
  my ($i,@seen,@ans) = (0);
  for (@ints) {
    if ($_ >= 0) {
      push(@seen,$_);
      $i++ if ($i < 0);
    } else {
      $i += $_ if (@seen);
      push(@ans,$seen[$i] // -1);
    } 
  }
  return @ans;
}

is([lastVisitor(5,-1,-1)],[5,-1],'Example 1');
is([lastVisitor(3,7,-1,-1,-1)],[7,3,-1],'Example 2');
is([lastVisitor(2,-1,4,-1,-1)],[2,4,2],'Example 3');
is([lastVisitor(10,20,-1,30,-1,-1)],[20,30,20],'Example 4');
is([lastVisitor(-1,-1,5,-1)],[-1,-1,5],'Example 5');

done_testing;
