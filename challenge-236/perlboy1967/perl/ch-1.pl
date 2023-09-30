#!/bin/perl

=pod

The Weekly Challenge - 236
- https://theweeklychallenge.org/blog/perl-weekly-challenge-236

Author: Niels 'PerlBoy' van Dijke

Task 1: Exact Change
Submitted by: Mohammad S Anwar

You are asked to sell juice each costs $5. You are given an array of bills. You can only 
sell ONE juice to each customer but make sure you return exact change back. You only have
$5, $10 and $20 notes. You do not have any change in hand at first.

Write a script to find out if it is possible to sell to each customers with correct change.

=cut

use v5.16;

use common::sense;

use Test::More;

sub exactChange (@) {
  my %r = (5 => 0, 10 => 0, 20 => 0);

  for (@_) {
    if ($_ == 5) {
      $r{5}++;
    } elsif ($_ == 10) {
      return 0 if ($r{5} < 1);
      $r{5}--; $r{10}++;
    } elsif ($_ == 20) {
      my $v = $_;
      if ($r{10} > 0) {
        $r{10}--; $v -= 10;
      }
      my $n = ($v - 5) / 5;
      return 0 if ($r{5} < $n);
      $r{5} -= $n; $r{20}++;
    } else {
      return 0;
    }
  } 

  return 1;
}

is(exactChange(5,5,5,10,20),1);
is(exactChange(5,5,10,10,20),0);
is(exactChange(5,5,5,20),1);
is(exactChange(5,5,20),0);
is(exactChange(5,10,5,10,20),0);

done_testing;
