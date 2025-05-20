#!/bin/perl

=pod

The Weekly Challenge - 322
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-322#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: String Format
Submitted by: Mohammad Sajid Anwar

You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of
size given by the integer. The first group can be smaller than the integer
but should have at least one character. Groups should be separated by dashes.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub stringFormat ($str,$len) {
  my @r;

  # Get first part 
  $str =~ s/([^-]{1,$len})//;
  push(@r,$1); 

  # Get the rest
  $str =~ s/-//g;
  1 while (push(@r,substr($str,0,$len,'')) && $str);

  return join('-',@r);
}

is(stringFormat('ABC-D-E-F',3),'ABC-DEF','Example 1');
is(stringFormat('A-BC-D-E',2),'A-BC-DE','Example 2');
is(stringFormat('-A-B-CD-E',4),'A-BCDE','Example 3');
is(stringFormat('ABC-DE-F',2),'AB-CD-EF','Own example');

done_testing;
