#!/bin/perl

=pod

The Weekly Challenge - 283
- L<https://theweeklychallenge.org/blog/perl-weekly-challenge-283>

Author: Niels 'PerlBoy' van Dijke

Task 2: Digit Count Value
Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range
0 <= i < size of array, the digit i occurs exactly the $ints[$i] times 
in the given array otherwise return false.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::MoreUtils qw(all frequency);

sub digitCountValue (@ints) {
  my ($i,%f) = (0,frequency(@ints));
  0 + all { ($f{$i++} // 0) == $_ } (@ints);
}

is(digitCountValue(1,2,1,0),1,'Example 1');
is(digitCountValue(0,3,0),0,'Example 2');

done_testing;
