#!/bin/perl

=pod

The Weekly Challenge - 319
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-319#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Word Count
Submitted by: Mohammad Sajid Anwar

You are given a list of words containing alphabetic characters only.

Write a script to return the count of words either starting with a vowel or
ending with a vowel.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub wordCount (@words) {
  return scalar grep /^[aeiou]|[aeiou]$/i, @words
}

is(wordCount(qw{Unicode XML Raku Perl}),2,'Example 1');
is(wordCount(qw{The weekly challenge}),2,'Example 2');
is(wordCount(qw{Perl Python PostgreSQL}),0,'Example 3');
is(wordCount(qw{Give it a go too}),5,'Own example');

done_testing;
