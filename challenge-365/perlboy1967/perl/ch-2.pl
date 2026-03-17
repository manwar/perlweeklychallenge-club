#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-365#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Valid Token Counter
Submitted by: Mohammad Sajid Anwar
You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count 
how many are valid words. A token is valid if it contains no digits, has at most
one hyphen surrounded by lowercase letters, and at most one punctuation mark 
(!, ., ,) appearing only at the end.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub validTokenCounter ($str) {
  scalar grep /^([a-z]+|[a-z]+-[a-z]+)[!,.]?$/,split ' ',$str;
}

is(validTokenCounter('cat and dog'),3,'Example 1');
is(validTokenCounter('a-b c! d,e'),2,'Example 2');
is(validTokenCounter('hello-world! this is fun'),4,'Example 3');
is(validTokenCounter('ab- cd-ef gh- ij!'),2,'Example 4');
is(validTokenCounter('wow! a-b-c nice.'),2,'Example 5');
is(validTokenCounter('weekly challenge is fun!'),4,'Own test');

done_testing;
