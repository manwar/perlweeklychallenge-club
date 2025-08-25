#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-336#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Equal Group
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return true if the given array can be divided into one or more 
groups: each group must be of the same size as the others, with at least two 
members, and with all members having the same value.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::Util qw(reduce);
use List::MoreUtils qw(frequency);

# Euclidean algorithm for GCD
sub gcd {
    my ($a, $b) = @_;
    while ($b != 0) {
        ($a, $b) = ($b, $a % $b);
    }
    return $a;
}

sub equalGroup (@ints) {
  my @f = values %{{frequency(@ints)}};
  return false if grep { $_ == 1 } @f;
  boolean (1 < reduce { gcd($a,$b) } @f);
}

is(equalGroup(1,1,2,2,2,2),true,'Example 1');
is(equalGroup(1,1,1,2,2,2,3,3),false,'Example 2');
is(equalGroup(5,5,5,5,5,5,7,7,7,7,7,7),true,'Example 3');
is(equalGroup(1,2,3,4),false,'Example 4');
is(equalGroup(8,8,9,9,10,10,11,11),true,'Example 5');

done_testing;
