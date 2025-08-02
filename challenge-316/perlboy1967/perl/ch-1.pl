#!/bin/perl

=pod

The Weekly Challenge - 316
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-316#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Circular
Submitted by: Mohammad Sajid Anwar

You are given a list of words.

Write a script to find out whether the last character of each word is the
first character of the following word.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use boolean;
use List::MoreUtils qw(slide all);

sub isCircular1 (@list) {
  my ($i,$res) = (0,1);
  do {
    $res &= substr($list[$i],-1,1) eq substr($list[$i+++1],0,1);
  } while ($res and $i < scalar $#list);
  return boolean($res);
}

sub isCircular2 (@list) {
  boolean all { $_ } slide { substr($a,-1,1) eq substr($b,0,1) } @list;
}

is(isCircular1(qw(perl loves scala)),true,'Example 1');
is(isCircular1(qw(love the programming)),false,'Example 2');
is(isCircular1(qw(java awk kotlin node.js)),true,'Example 3');

is(isCircular2(qw(perl loves scala)),true,'Example 1');
is(isCircular2(qw(love the programming)),false,'Example 2');
is(isCircular2(qw(java awk kotlin node.js)),true,'Example 3');

done_testing;
