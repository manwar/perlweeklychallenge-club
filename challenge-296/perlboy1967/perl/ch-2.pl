#!/bin/perl

=pod

The Weekly Challenge - 271
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-296#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Matchstick Square
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if it is possible to make one square using the sticks as
in the given array @ints where $ints[ì] is the length of ith stick.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

use boolean;
use List::AllUtils qw(sum indexes);

no warnings qw(experimental::signatures);
sub canMatchstickSquare (@stickLengths) {
  my $sum = sum(@stickLengths);

  # Quick check. Is it possible at all?
  return false if ($sum % 4 != 0);

  # Devide sum by 4
  my $side = $sum >> 2;

  # Arrange sticks from small to large
  @stickLengths = sort { $a <=> $b } @stickLengths;

  while (@stickLengths) {
    # Get largest stick available
    my $s = pop(@stickLengths);
    while ($s < $side) {
      # Calculate needed resulting length needed
      my $r = $side - $s;

      # Get largest stick to make or approach
      # the wanted length best
      my @idx = indexes { $_ <= $r } @stickLengths;

      # Return if we ran out of proper sticks
      return false if (scalar(@idx) == 0);

      # Grow the length with best candidate
      $s += splice(@stickLengths,$idx[-1],1);
    }
  }

  return true;
}

is(true, canMatchstickSquare(1,2,2,2,1),'Example 1');
is(false,canMatchstickSquare(2,2,2,4),'Example 2');
is(false,canMatchstickSquare(2,2,2,2,4),'Example 3');
is(true, canMatchstickSquare(3,4,1,4,3,1),'Example 4');
is(false,canMatchstickSquare(1,2,3,4),'Own Example 1');
is(true, canMatchstickSquare(1,6,2,5,3,4,7),'Own Example 2');
is(true, canMatchstickSquare(1,8,2,7,3,6,4,5),'Own Example 2');
 
done_testing;
