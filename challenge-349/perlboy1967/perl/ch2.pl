#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-349#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Meeting Point
Submitted by: Mohammad Sajid Anwar

You are given instruction string made up of U (up), D (down), L (left) and R (right).

Write a script to return true if following the instruction, you meet the starting point (0,0).

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(uniq);

sub meetingPoint ($path) {
  my %f = qw(L 0 R 0 U 0 D 0);
  $f{$_}++ for (split//,$path);
  boolean (($f{U} == $f{D}) and ($f{R} == $f{L}));
}

is(meetingPoint('ULD'),false,'Example 1');
is(meetingPoint('ULDR'),true,'Example 2');
is(meetingPoint('UUURRRDDD'),false,'Example 3');
is(meetingPoint('UURRRDDLLL'),true,'Example 4');
is(meetingPoint('RRUULLDDRRUU'),false,'Example 5');
is(meetingPoint('RDRUULLD'),true,'Own Example');

done_testing;
