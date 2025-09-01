#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-337#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Smaller Than Current
Submitted by: Mohammad Sajid Anwar

You are given an array of numbers, @num1.

Write a script to return an array, @num2, where $num2[i] is the count of
all numbers less than or equal to $num1[i].

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub smallerThanCurrent (@ints) {
  my %cache;
  map { my $i = $_; $cache{$i} //= scalar(grep { $_ < $i } @ints); $cache{$i} } @ints;
}

is([smallerThanCurrent(6,5,4,8)],[2,1,0,3],'Example 1');
is([smallerThanCurrent(7,7,7,7)],[0,0,0,0],'Example 2');
is([smallerThanCurrent(5,4,3,2,1)],[4,3,2,1,0],'Example 3');
is([smallerThanCurrent(-1,0,3,-2,1)],[1,2,4,0,3],'Example 4');
is([smallerThanCurrent(0,2,2,4,0)],[0,2,2,4,0],'Example 5');
is([smallerThanCurrent((1) x 10_000)],[(0) x 10_000],'Own example');

done_testing;
