#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-359#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: String Reduction
Submitted by: Mohammad Sajid Anwar

You are given a word containing only alphabets,

Write a function that repeatedly removes adjacent duplicate characters from a string
until no adjacent duplicates remain and return the final word.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub stringReduction ($word) {
  1 while ($word =~ s/(.)\1//g or return $word);
}

is(stringReduction('aabbccdd'),'','Example 1');
is(stringReduction('abccba'),'','Example 2');
is(stringReduction('abcdef'),'abcdef','Example 3');
is(stringReduction('aabbaeaccdd'),'aea','Example 4');
is(stringReduction('mississippi'),'m','Example 5');

done_testing;
