#!/bin/perl

=pod

The Weekly Challenge - 193
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-193/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Binary String
Submitted by: Mohammad S Anwar

You are given an integer, $n > 0.

Write a script to find all possible binary numbers of size $n.

=cut

use v5.16;
use warnings;


sub binaryString ($) {
  map { sprintf("%0$_[0]b", $_) } (0 .. (1<<$_[0])-1);
}


for (1 .. 5) {
  say join(",", binaryString($_));
}
