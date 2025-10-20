#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-344#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Array Form Compute
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $x.

Write a script to add $x to the integer in the array-form.

|| The array form of an integer is a digit-by-digit representation stored 
|| as an array, where the most significant digit is at the 0th index.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub arrayFormCompute ($x,@ints) {
  split(//,int(join('',@ints))+$x);
}

is([arrayFormCompute(12,1,2,3,4)],[1,2,4,6],'Example 1');
is([arrayFormCompute(181,2,7,4)],[4,5,5],'Example 2');
is([arrayFormCompute(1,9,9,9)],[1,0,0,0],'Example 3');
is([arrayFormCompute(9999,1,0,0,0,0)],[1,9,9,9,9],'Example 4');
is([arrayFormCompute(1000,0)],[1,0,0,0],'Example 5');
is([arrayFormCompute(123,9,8,7)],[1,1,1,0],'Own example');

done_testing;
