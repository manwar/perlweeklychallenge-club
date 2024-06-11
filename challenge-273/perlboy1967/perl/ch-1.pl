#!/bin/perl

=pod

The Weekly Challenge - 273
- https://theweeklychallenge.org/blog/perl-weekly-challenge-273

Author: Niels 'PerlBoy' van Dijke

Task 1: Percentage of Character
Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character $char.

Write a script to return the percentage, nearest whole, of given
character in the given string.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub percentageOfString ($str,$char) {
  my %f; $f{$_}++ for (split(//,$str));
  int(0.5 + 100 * ($f{$char} // 0) / length($str));
}

is(percentageOfString('perl','e'),25,'Example 1');
is(percentageOfString('java','a'),50,'Example 2');
is(percentageOfString('python','m'),0,'Example 3');
is(percentageOfString('ada','67'),0,'Example 4');

done_testing;
