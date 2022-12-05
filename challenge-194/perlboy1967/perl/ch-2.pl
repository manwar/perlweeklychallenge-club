#!/bin/perl

=pod

The Weekly Challenge - 194
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-194/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Frequency Equalizer
Submitted by: Mohammad S Anwar

You are given a string made of alphabetic characters only, a-z.

Write a script to determine whether removing only one character can make
the frequency of the remaining characters the same.

=cut

use v5.16;
use warnings;

use List::MoreUtils qw(frequency minmax);

use Test::More;


sub freqEqual ($) {
  my %f = frequency(split//,$_[0]);
  my ($min,$max) = minmax(keys {reverse %f});
  return $min == $max-1 ? 1 : 0;
}


my %t = qw(abbc 1 xyzyyxz 1 xzxz 0);

for (sort keys %t) {
 is(freqEqual($_),$t{$_},"freqEqual('$_')");
}

done_testing;
