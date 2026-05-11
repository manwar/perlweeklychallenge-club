#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-372#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Largest Substring
Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to return the length of the largest substring between two equal
characters excluding the two characters. Return -1 if there is no such substring.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub largestSubstring ($str) {
  # Get all unique characters
  my %f; map { $f{$_}++ } split//,$str;
  # Finx maximum distance between same characters
  max(map { $str =~ m#$_(.*)$_#; length($1 // ''); } keys %f);
}

is(largestSubstring('aaaaa'),3);
is(largestSubstring('abcdeba'),5);
is(largestSubstring('abbc'),0);
is(largestSubstring('abcaacbc'),4);
is(largestSubstring('laptop'),2);

done_testing;
