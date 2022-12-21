#!/bin/perl

=pod

The Weekly Challenge - 195
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-195/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Special Integers
Submitted by: Mohammad S Anwar

You are given a positive integer, $n > 0.

Write a script to print the count of all special integers between 1 and $n.

||  An integer is special when all of its digits are unique.

=cut

use v5.16;
use common::sense;

use Test::More;


sub numSpecialInt ($) {
  return $_[0] if ($_[0] < 11);

  my $r = $_[0];

  for (map {$_ x length($_[0])} 1 .. 9) {
    $r-- if ($_ <= $_[0]);
    last if ($_ >= $_[0]);
  }

  return $r;
}


for (
  [1,1], [5,5], [9,9],
  [10,10], [11,10], [12,11], 
  [110,110], [111,110], [112,111],
  [332,330], [333,330], [334,331],
  [4443,4440], [4444,4440], [4445,4441],
) {
  is(numSpecialInt($$_[0]), $$_[1], "Test $$_[0]");
} 

done_testing;
