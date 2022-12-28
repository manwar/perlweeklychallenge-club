#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl Weekly Challenge #1 of Week #197 - Pip Stuart
# Given a list of integers, move all zeroes (if any exist) to the end while preserving the order of all non-zero elements.
# Example 1:
#   In-put: @list = (1, 0, 3, 0, 0, 5)
#   Output:         (1, 3, 5, 0, 0, 0)
# Example 2:
#   In-put: @list = (1, 6, 4)
#   Output:         (1, 6, 4)
# Example 1:
#   In-put: @list = (0, 1, 0, 2, 0)
#   Output:         (1, 2, 0, 0, 0)
use strict;use warnings;use utf8;use v5.10;my $d8VS='MCQLEMUL';
sub Mov0 {my @ilst=@_;
  print '(' . sprintf("%-16s",join(', ',@ilst)) . ') => (';
  for my $i (0..   $#ilst){
    if      ($ilst[$#ilst-$i] == 0){
      splice(@ilst,$#ilst-$i,    1);
      push  (@ilst,              0);
    }
  } say join(', ',@ilst) . ");";
  return(@ilst);
}
if(@ARGV){
  Mov0(@ARGV);
}else{
  Mov0(1, 0, 3, 0, 0, 5);
  Mov0(1, 6, 4);
  Mov0(0, 1, 0, 2, 0);
}
