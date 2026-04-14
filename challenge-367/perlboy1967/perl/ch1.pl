#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-367#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Odd Binary
Submitted by: Mohammad Sajid Anwar
You are given a binary string that has at least one ‘1’.

Write a script to rearrange the bits in such a way that the resulting binary number
is the maximum odd binary number and return the resulting binary string. The resulting
string can have leading zeros.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub maxOddBinary ($str) {
  my @c=('',''); $str =~ s/(.)/$c[$1].=$1/ge;
  return substr($c[1],1).$c[0].1;
}

is(maxOddBinary('1011'),'1101','Example 1');
is(maxOddBinary('100'),'001','Example 2');
is(maxOddBinary('111000'),'110001','Example 3');
is(maxOddBinary('0101'),'1001','Example 4');
is(maxOddBinary('1111'),'1111','Example 5');

done_testing;
