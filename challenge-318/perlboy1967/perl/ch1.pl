#!/bin/perl

=pod

The Weekly Challenge - 318
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-318#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Group Position
Submitted by: Mohammad Sajid Anwar

You are given a string of lowercase letters.

Write a script to find the position of all groups in the given string.
Three or more consecutive letters form a group. Return "” if none found.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub groupPosition ($str) {
  my @r;
  push(@r,$1.$2) while ($str =~ m#(.)(\1{2,})#g);
  return @r;
}

is([groupPosition('abccccd')],
                 [qw(cccc)],'Example 1');
is([groupPosition('aaabcddddeefff')],
                 [qw(aaa dddd fff)],'Example 2');
is([groupPosition('abcdd')],
                 [],'Example 3');

done_testing;

