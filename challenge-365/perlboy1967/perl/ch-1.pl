#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-365#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Alphabet Index Digit Sum
Submitted by: Mohammad Sajid Anwar
You are given a string $str consisting of lowercase English letters, and an integer $k.

Write a script to convert a lowercase string into numbers using alphabet positions
(a=1 ..  z=26), concatenate them to form an integer, then compute the sum of its digits
repeatedly $k times, returning the final value.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::AllUtils qw(sum);

sub alpIndDigSum ($str,$k) {
  # Create character to integer map
  my $m //= { map { (chr(ord('a')+$_-1),$_) } 1 .. 26 };
  # Calculate initial conversion value
  my $i = join '', map { $m->{$_} } split '',$str;
  # Calulate  iteration values
  $i = sum(split '',$i) while (--$k >=0 and $i > 10);
  # And return
  return $i;
}

is(alpIndDigSum('abc',1),6,'Example 1');
is(alpIndDigSum('az',2),9,'Example 2');
is(alpIndDigSum('cat',1),6,'Example 3');
is(alpIndDigSum('dog',2),8,'Example 4');
is(alpIndDigSum('perl',3),6,'Example 5');

done_testing;
