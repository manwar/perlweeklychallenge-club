#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #202 - Pip Stuart
# Task1: Consecutive Odds:  Submitted by: Mohammad S Anwar;  You are given an array of integers.
# Write a script to print 1 if there are THREE consecutive odds in the given array otherwise print 0.
# Example1:
#   In-put: @array = (1,5,3,6)
#   Output:           1
# Example2:
#   In-put: @array = (2,6,3,5)
#   Output:           0
# Example3:
#   In-put: @array = (1,2,3,4)
#   Output:           0
# Example4:
#   In-put: @array = (2,3,5,7)
#   Output:           1
use strict;use warnings;use utf8;use v5.10.1;my $d8VS='N1ULBEST';
sub COds {my @aray=@_;my %hodf=();my $has3=0;
  print '(' . sprintf("%-7s",join(',',@aray)) . ') => ';
  for (   @aray) { $hodf{$_}=1 if ($_ % 2); }
  for (0..@aray) {
    if (exists($hodf{$_}) && exists($hodf{$_+2}) && exists($hodf{$_+4})) { $has3=1;last; } }
  say    $has3 . ';';
  return($has3);
}
if    (@ARGV) {
  COds(@ARGV);
} else {
  COds(1,5,3,6); # => 1
  COds(2,6,3,5); # => 0
  COds(1,2,3,4); # => 0
  COds(2,3,5,7); # => 1
}
