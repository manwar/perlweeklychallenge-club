#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #208 - Pip Stuart
# Task2: Duplicate and Missing:  Submitted by: Mohammad S Anwar;  You are given an array of integers in sequence with one missing and one duplicate.
#   Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.
#     For the sake of this task, let us assume the array contains no more than one duplicate and missing.
# Example1:
#   In-put: @nums = (1,2,2,4)
#   Output: (2,3)
#     Duplicate is 2 and Missing is 3.
# Example2:
#   In-put: @nums = (1,2,3,4)
#   Output: -1
#     No duplicate and missing found.
# Example3:
#   In-put: @nums = (1,2,3,3)
#   Output: (3,4)
#     Duplicate is 3 and Missing is 4.
# Last date to submit the solution 23:59 (UK Time) Sunday 19th March 2023.
use strict;use warnings;use utf8;use v5.12;my $d8VS='N3JM5uBR';
sub DpaM {my @nums = sort { $a <=> $b } @_;my @dpam = ();my %hasn = ();
  for (0..$#nums-1) {
    if ($nums[$_] == $nums[$_+1]) {
      push(@dpam,    $nums[$_  ]      ); last;
    }
  }
  for (0..$#nums  ) {       $hasn{$nums[$_]} = 1; }
  for (0..$#nums  ) {
    if  (  @dpam && !exists($hasn{$_+1})) {
      push(@dpam,                 $_+1); last;
    }
  }
  printf(                "(%-7s) => ", join(',', @nums));
  if    (@dpam) { printf("(%s);\n",    join(',', @dpam)); }
  else          { say      "-1;"; }
  return(@dpam);
}
if    (@ARGV) {
  DpaM(@ARGV);
} else {
  DpaM(1,2,2,4); # => (2,3);
  DpaM(1,2,3,4); # => -1   ;
  DpaM(1,2,3,3); # => (3,4);
}
