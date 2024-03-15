#!/bin/perl

=pod

The Weekly Challenge - 260
- https://theweeklychallenge.org/blog/perl-weekly-challenge-260

Author: Niels 'PerlBoy' van Dijke

Task 2: Dictionary Rank
Submitted by: Mark Anderson

You are given a word, $word.

Write a script to compute the dictionary rank of the given word.
(out of n combinations using its individual characters)

=cut

use v5.32;
use feature q(signatures);
use common::sense;

use Test2::V0;

use Algorithm::Combinatorics qw(permutations);
use List::AllUtils qw(uniq firstidx);

sub dictionaryRank ($word) {
  1 + firstidx {$_ eq $word} uniq sort map {join '',@$_} permutations([split //,$word]);
}

is(dictionaryRank('CAT'),3,'CAT');
is(dictionaryRank('GOOGLE'),88,'GOOGLE');
is(dictionaryRank('SECRET'),255,'SECRET');

done_testing;
