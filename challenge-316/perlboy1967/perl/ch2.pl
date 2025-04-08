#!/bin/perl

=pod

The Weekly Challenge - 316
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-316#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Subsequence
Submitted by: Mohammad Sajid Anwar

You are given two string.

Write a script to find out if one string is a subsequence of another.

|| A subsequence of a string is a new string that is formed from the original string
|| by deleting some (can be none)  of the characters without disturbing the relative
|| positions of the remaining characters.


=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use boolean;

sub isSubsequence ($s1,$s2) {
  my $re = join '.*?', split '', $s1;
  boolean $s2 =~ m#$re#;
}

is(isSubsequence(qw(uvw bcudvew)), true, 'Example 1');
is(isSubsequence(qw(aec abcde)), false, 'Example 2');
is(isSubsequence(qw(sip javascript)), true, 'Example 3');

done_testing;
