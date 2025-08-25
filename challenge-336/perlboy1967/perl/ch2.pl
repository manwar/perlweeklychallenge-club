#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-336#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Final Score
Submitted by: Mohammad Sajid Anwar

You are given an array of scores by a team.

Write a script to find the total score of the given team. The score can be any 
integer, +, C or D. The + adds the sum of previous two scores. The score C
invalidates the previous score. The score D will double the previous score.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(sum0);

sub finalScore (@scores) {
  my @stack;
  for my $score (@scores) {
    given($score) {
      when('C') { pop(@stack) if (@stack); next }
      when('D') { push(@stack,$stack[-1] * 2) if (@stack); next }
      when('+') { push(@stack,$stack[-1] + $stack[-2]) if (@stack > 1); next }
      default   { push(@stack,$_) }
    }
  }
  sum0(@stack); 
}

is(finalScore(qw{5 2 C D +}),30,'Example 1');
is(finalScore(qw{5 -2 4 C D 9 + +}),27,'Example 2');
is(finalScore(qw{7 D D C + 3}),45,'Example 3');
is(finalScore(qw{-5 -10 + D C +}),-55,'Example 4');
is(finalScore(qw{3 6 + D C 8 + D -2 C +}),128,'Example 5');
is(finalScore(qw{1 + C D 0}),0,'Own Example 1');
is(finalScore(qw{0 C D 0}),0,'Own Example 2');
is(finalScore(qw{C D 0}),0,'Own Example 3');

done_testing;
