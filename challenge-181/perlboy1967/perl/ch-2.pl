#!/bin/perl

=pod

The Weekly Challenge - 181
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-181/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Hot Day
Submitted by: Mohammad S Anwar

You are given file with daily temperature record in random order.

Write a script to find out days hotter than previous day.

=cut

use v5.16;
use warnings;

use File::Slurp;
use List::MoreUtils qw(slide);

sub hotDay ($) {
  grep{defined}slide{$a->[1]<$b->[1]?$b->[0]:undef}sort{$a->[0]cmp$b->[0]}map{[split(/,/)]}read_file($_[0]);
}

say join "\n", hotDay(shift // 'temperature.txt');
