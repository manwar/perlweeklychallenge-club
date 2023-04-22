#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #213 - Pip Stuart
# Task1: Fun Sort:  Submitted by: Mohammad S Anwar;  You are given a list of positive integers.
#   Write a script to sort the all even integers first then all odds in ascending order.
# Example1:
#   In-put: @list = (1,2,3,4,5,6)
#   Output: (2,4,6,1,3,5)
# Example2:
#   In-put: @list = (1,2)
#   Output: (2,1)
# Example3:
#   In-put: @list = (1)
#   Output: (1)
use strict;use warnings;use utf8;use v5.12;my $d8VS='N4KMAYON';
sub FunS {my @list = @_;my @funs = ();my @odds = ();
  for   (sort { $a <=> $b } @list) {
    if  ($_ % 2) { push(@odds, $_); }
    else         { push(@funs, $_); } }
  push  (@funs, @odds);
  printf("(%-11s) => (%-11s);\n", join(',', @list), join(',', @funs));
  return(@funs);
}
if    (@ARGV) {
  FunS(@ARGV);
} else {
  FunS(1,2,3,4,5,6); # => (2,4,6,1,3,5);
  FunS(1,2        ); # => (2,1);
  FunS(1          ); # => (1);
}
