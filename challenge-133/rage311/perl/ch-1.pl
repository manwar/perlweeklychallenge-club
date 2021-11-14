#!/usr/bin/env perl

use 5.034;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use Test::Simple tests => 4;

# TASK #1 › Integer Square Root
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
# Write a script to calculate the integer square root of the given number.

sub int_sqrt ($in) {
  my $guess = int($in / 2);
  while ((my $new_guess = int(($guess + int($in / $guess)) * 0.5)) != $guess) {
    $guess = $new_guess;
  }
  return $guess;
}

ok(int_sqrt(10)  == 3,  'int_sqrt(10) == 3');
ok(int_sqrt(27)  == 5,  'int_sqrt(27) == 5');
ok(int_sqrt(85)  == 9,  'int_sqrt(85) == 9');
ok(int_sqrt(101) == 10, 'int_sqrt(101) == 10');
