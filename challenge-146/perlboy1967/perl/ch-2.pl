#!/bin/perl

=pod

The Weekly Challenge - 146
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-146/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Curious Fraction Tree
Submitted by: Mohammad S Anwar

You are given a fraction, member of the tree created similar to the above sample.

Write a script to find out the parent and grandparent of the given member.
Example 1:

    Input: $member = '3/5';
    Output: parent = '3/2' and grandparent = '1/2'

Example 2:

    Input: $member = '4/3';
    Output: parent = '1/3' and grandparent = '1/2'

=cut

use v5.16;

my $m = shift // '3/5';
my $p = getCFTparent($m);
my $g = getCFTparent($p);

printf "member = '%s' has parent = '%s' and grandparent = '%s'\n", $m, $p, $g;

sub getCFTparent($) {
  my ($n) = @_;

  ($a, $b) = split(/\//, $n);

  if ($a < $b) {
    return sprintf('%d/%d', $a, $b - $a);
  } elsif ($a > $b) {
    return sprintf('%d/%d', $a - $b, $b);
  }
} 
