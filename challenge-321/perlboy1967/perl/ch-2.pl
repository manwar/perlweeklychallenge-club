#!/bin/perl

=pod

The Weekly Challenge - 321
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-321#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Backspace Compare
Submitted by: Mohammad Sajid Anwar

You are given two strings containing zero or more #.

Write a script to return true if the two given strings are same by treating # as backspace.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use boolean;

sub backspaceCompare ($s1,$s2) {
  map { 1 while (s/[^#]#//) } $s1,$s2;
  boolean ($s1 eq $s2);
}

is(true, backspaceCompare('ab#c','ad#c'),'Example 1');
is(true, backspaceCompare('ab##','a#b#'),'Example 2');
is(false,backspaceCompare('a#b','c'),'Example 3');

done_testing;
