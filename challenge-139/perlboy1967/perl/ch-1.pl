#!/bin/perl

=pod

The Weekly Challenge - 139
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-139/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › JortSort
Submitted by: Mohammad S Anwar

You are given a list of numbers.

Write a script to implement JortSort. It should return true/false depending 
if the given list of numbers are already sorted.

=cut

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(none slide);

sub jortSort(@) {
  no warnings 'once';
  none{$_<0}(slide{$b-$a}@_);
}

printf "(%s) => %d\n", join(',',@ARGV), jortSort(@ARGV) // 'undef';
