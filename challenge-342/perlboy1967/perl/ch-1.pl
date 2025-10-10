#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-342#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Balance String
Submitted by: Mohammad Sajid Anwar

You are given a string made up of lowercase English letters and digits only.

Write a script to format the give string where no letter is followed by
another letter and no digit is followed by another digit. If there are 
multiple valid rearrangements, always return the lexicographically smallest
one. Return empty string if it is impossible to format the string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::MoreUtils qw(zip);

sub balanceString ($str) {
  my (@d,@c);

  map { /\d/ ? push(@d,$_) : push(@c,$_) } sort split(//,$str);

  return '' if (abs(@d - @c) > 1);

  if (@c <= @d) {
    push(@c,'') if @c != @d;
    return join '', zip(@d,@c);
  } elsif (@c > @d) {
    push(@d,'');
    return join '', zip(@c,@d);
  }
}

is(balanceString('a0b1c2'),'0a1b2c','Example 1');
is(balanceString('abc12'),'a1b2c','Example 2');
is(balanceString('0a2b1c3'),'0a1b2c3','Example 3');
is(balanceString('1a23'),'','Example 4');
is(balanceString('ab123'),'1a2b3','Example 5');
is(balanceString('a'),'a','Own example 1');
is(balanceString('1'),'1','Own example 2');
is(balanceString('zyx321'),'1x2y3z','Own example 3');

done_testing;
