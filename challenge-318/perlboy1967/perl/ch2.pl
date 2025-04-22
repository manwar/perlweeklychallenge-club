#!/bin/perl

=pod

The Weekly Challenge - 318
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-318#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Reverse Equals
Submitted by: Roger Bell_West

You are given two arrays of integers, each containing the same elements as the other.

Write a script to return true if one array can be made to equal the other by reversing
exactly one contiguous subarray.

=cut

use v5.32;
use common::sense;
use Test2::V0 qw(-no_srand);

use boolean;
use List::MoreUtils qw(all indexes slide zip6);

sub reverseEquals (\@\@) {
  my ($ar1,$ar2) = @_;

  # Return true if equal lists
  return true if (join('',@$ar1) eq join('',@$ar2));

  # Find index of equal and unequal elements
  my @ne = indexes { $$_[0] != $$_[1] } zip6 @$ar1,@$ar2;
  boolean (
    all { $_ == 1 } slide { $b - $a == 1 ? 
                              1 : 
                              join('',@$ar1[$a+1..$b-1]) eq join('',@$ar2[$a+1..$b-1]) 
                          } @ne
      and
    join('',@$ar1[@ne]) eq join('',reverse @$ar2[@ne])
  );
}

is(reverseEquals(@{[3,2,1,4]},@{[1,2,3,4]}),true,'Example 1');
is(reverseEquals(@{[1,3,4]},@{[4,1,3]}),false,'Example 2');
is(reverseEquals(@{[2]},@{[2]}),true,'Example 3');
is(reverseEquals(@{[1,2,3,3,2,1]},@{[2,1,3,2,3,1]}),false,'Own Example 1');
is(reverseEquals(@{[1,2,3,2,3,4]},@{[3,2,3,2,1,4]}),true,'Own Example 2');

done_testing;

