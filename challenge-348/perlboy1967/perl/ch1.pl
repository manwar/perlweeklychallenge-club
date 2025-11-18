#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-348#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: String Alike
Submitted by: Mohammad Sajid Anwar

You are given a string of even length.

Write a script to find out whether the given string can be split into two
halves of equal lengths, each with the same non-zero number of vowels.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;

sub stringAlike ($str) {
  my $len = length($str);
  # Must be even length string
  return false unless $len % 2 == 0;
  # Half the length for two identical long sub-strings
  $len >>= 1;
  # Get both half and their vowel length
  my @p = grep { $_ != 0 } map { length s/[^aeiou]+//gir } unpack("(A$len)(A$len)",$str);
  # Compare length and zero length check
  return boolean (@p == 2 and $p[0] == $p[1])
}

is(stringAlike('textbook'),false,'Example 1');
is(stringAlike('book'),true,'Example 2');
is(stringAlike('AbCdEfGh'),true,'Example 3');
is(stringAlike('rhythmmyth'),false,'Example 4');
is(stringAlike('UmpireeAudio'),false,'Example 5');

done_testing;
