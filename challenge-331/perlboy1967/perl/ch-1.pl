#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-331#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Last Word
Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find the length of last word in the given string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub lastWord ($str) {
  length(($str =~ m#(\S+)\b[\W]*$#)[0]);
}

is(lastWord(q{The Weekly Challenge}),9,'Example 1');
is(lastWord(q{   Hello   World   }),5,'Example 2');
is(lastWord(q{Let's begin the fun}),3,'Example 3');
is(lastWord(q{Hello TWC!}),3,'Own example');

done_testing;
