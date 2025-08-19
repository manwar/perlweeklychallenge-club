#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-333#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Duplicate Zeros
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of zero, shifting the remaining
elements to the right. The elements beyond the length of the original array
are not written.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub duplicateZeros (@ints) {
  my @r;
  for (@ints) {
    push(@r,$_ ? $_ : (0,0)); last if (@r >= @ints) ;
  }
  @r[0..$#ints];
}

is([duplicateZeros(1,0,2,3,0,4,5,0)],[1,0,0,2,3,0,0,4],'Example 1');
is([duplicateZeros(1,2,3)],[1,2,3],'Example 2');
is([duplicateZeros(1,2,3,0)],[1,2,3,0],'Example 3');
is([duplicateZeros(0,0,1,2)],[0,0,0,0],'Example 4');
is([duplicateZeros(1,2,0,3,4)],[1,2,0,0,3],'Example 5');

done_testing;
