#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-353#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Words
Submitted by: Mohammad Sajid Anwar

You are given an array of sentences.

Write a script to return the maximum number of words that appear in a single sentence.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qq(max);

sub maxWords (@sentences) {
  max map { 0 + split /\s+/ } @sentences;
}

is(maxWords('Hello world','This is a test','Perl is great'),4,'Example 1');
is(maxWords('Single'),1,'Example 2');
is(maxWords('Short','This sentence has seven words in total','A B C',
            'Just four words here'),7,'Example 3');
is(maxWords('One','Two parts','Three parts phrase',''),3,'Example 4');
is(maxWords('The quick brown fox jumps over the lazy dog','A',
            'She sells seashells by the seashore',
            'To be or not to be that is the question'),10,'Example 5');

done_testing;
