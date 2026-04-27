#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-370#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Popular Word
Submitted by: Mohammad Sajid Anwar

You are given a string paragraph and an array of the banned words.

Write a script to return the most popular word that is not banned. It 
is guaranteed there is at least one word that is not banned and the
answer is unique. The words in paragraph are case-insensitive and the
answer should be in lowercase. The words can not contain punctuation
symbols.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub popularWord ($paragraph,@banned) {
  my %words;
  # Do frequency analysis of words in paragraph
  $words{$_}++ for (lc($paragraph) =~ m#[a-zA-Z]+#g);
  # Delete banned words
  delete @words{@banned};
  # Sort on frequency reversed and return first key
  return (sort { $words{$b} <=> $words{$a} } keys(%words))[0];
}

is(popularWord('Bob hit a ball, the hit BALL flew far after it was hit.',
               qw(hit)),'ball','Example 1');
is(popularWord('Apple? apple! Apple, pear, orange, pear, apple, orange.',
               qw(apple pear)),'orange','Example 2');
is(popularWord('A. a, a! A. B. b. b.',
               qw(b)),'a','Example 3');
is(popularWord('Ball.ball,ball:apple!apple.banana',
               qw(ball)),'apple','Example 4');
is(popularWord('The dog chased the cat, but the dog was faster than the cat.',
               qw(the dog)),'cat','Example 5');

done_testing;
