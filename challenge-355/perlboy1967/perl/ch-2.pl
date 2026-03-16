#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-355#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Mountain Array
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return true if the given array is a valid mountain array.

|| An array is mountain if and only if:
|| 1) arr.length >= 3
|| and
|| 2) There exists some i with 0 < i < arr.length - 1 such that:
|| arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
|| arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;

use List::MoreUtils qw(all slide part arrayify);

sub mountainArray (@ints) {
  return false if @ints < 3;
  state $s //= [qw(0 p n)];
  boolean ((join '', slide { $s->[$b <=> $a] } @ints) =~ /^[p]+[n]+$/);
}

is(mountainArray(1,2,3,4,5),false,'Example 1');
is(mountainArray(0,2,4,6,4,2,0),true,'Example 2');
is(mountainArray(5,4,3,2,1),false,'Example 3');
is(mountainArray(1,3,5,5,4,2),false,'Example 4');
is(mountainArray(1,3,2),true,'Example 5');
is(mountainArray(1,2),false,'Own Test 1');
is(mountainArray(2,1,2),false,'Own Test 2');

done_testing;
