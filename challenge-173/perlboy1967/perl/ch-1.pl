#!/bin/perl

=pod

The Weekly Challenge - 173 - Task 1
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-172/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Esthetic Number
Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find out if the given number is Esthetic Number.

|| An esthetic number is a positive integer where every adjacent digit 
|| differs from its neighbour by 1.

=cut

use v5.16;
use warnings;

use List::MoreUtils qw(all slide);
use Test::More;

sub isEstheticNumber($) {
  no warnings 'once'; all {$_} slide {abs($a-$b)==1} split //, shift;
}

is(isEstheticNumber(5456),1);
is(isEstheticNumber(120),0);

done_testing()

