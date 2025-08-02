#!/bin/perl

=pod

The Weekly Challenge - 325
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-325#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Final Price
Submitted by: Mohammad Sajid Anwar

You are given an array of item prices.

Write a script to find out the final price of each items in the given array.

There is a special discount scheme going on. If there’s an item with a lower
or equal price later in the list, you get a discount equal to that later price
(the first one you find in order).

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::MoreUtils qw(firstidx);

sub finalPrice (@prices) {
  my @n;

  while (@prices) {
    push(@n,shift(@prices));
    my $m = firstidx { $_ <= $n[-1] } @prices;
    $n[-1] -= $prices[$m] if $m >= 0;
  }

  return @n;
}

is([finalPrice(8,4,6,2,3)],[4,2,4,2,3],'Example 1');
is([finalPrice(1,2,3,4,5)],[1,2,3,4,5],'Example 2');
is([finalPrice(7,1,1,5)],[6,0,1,5],'Example 3');

done_testing;
