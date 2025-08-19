#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-335#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Common Characters
Submitted by: Mohammad Sajid Anwar

You are given an array of words.

Write a script to return all characters that is in every word in the given
array including duplicates.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(min);
use List::MoreUtils qw(frequency);

sub commonCharacters (@words) {
  my (%chars,@wFreq);
  # Build list with word character frequency numbers
  push(@wFreq,{ frequency map { $chars{$_} = 1; $_ } split // }) for (@words);
  # Return common characters based on minimum found per character
  return map { 
    my $char = $_; ($char) x min(map { $$_{$char} // 0 } @wFreq);
  } sort keys %chars;
}

is [commonCharacters(qw{bella label roller})],[qw{e l l}],'Example 1';
is [commonCharacters(qw{cool lock cook})],[qw{c o}],'Example 2';
is [commonCharacters(qw{hello world pole})],[qw{l o}],'Example 3';
is [commonCharacters(qw{abc def ghi})],[],'Example 4';
is [commonCharacters(qw{aab aac aaa})],[qw{a a}],'Example 5';

done_testing()
