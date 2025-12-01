#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-350#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Good Substrings
Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the number of good substrings of length three in the given string.

|| A string is good if there are no repeated characters.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::MoreUtils q(frequency);

sub goodSubstrings ($str) {
  grep { keys %{{frequency split(//)}}  == 3}
    map { substr($str,$_,3) } ( 0 .. length($str) - 3);
}

is(goodSubstrings('abcaefg'),5,'Example 1');
is(goodSubstrings('xyzzabc'),3,'Example 2');
is(goodSubstrings('aababc'),1,'Example 3');
is(goodSubstrings('qwerty'),4,'Example 4');
is(goodSubstrings('zzzaaa'),0,'Example 5');

done_testing;
