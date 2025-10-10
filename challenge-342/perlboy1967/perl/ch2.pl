#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-342#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Max Score
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, containing 0 and 1 only.

Write a script to return the max score after splitting the string into 
two non-empty substrings. The score after splitting a string is the number
of zeros in the left substring plus the number of ones in the right substring.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub maxScore ($str) {
  max map { 
        substr($str,0,$_) =~ tr/0/0/ + substr($str,$_) =~ tr/1/1/ 
      } (1 .. length($str) - 1);
}

is(maxScore('0011'),4,'Example 1');
is(maxScore('0000'),3,'Example 2');
is(maxScore('1111'),3,'Example 3');
is(maxScore('0101'),3,'Example 4');
is(maxScore('011101'),5,'Example 5');

done_testing;
