#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #203 - Pip Stuart
# Task1: Special Quadruplets:  Submitted by: Mohammad S Anwar;  You are given an array of integers.
# Write a script to find out the total special quadruplets for the given array.
# Special Quadruplets are such that satisfies the following 2 rules.
#   1) nums[a] + nums[b] + nums[c] == nums[d]
#   2) a < b < c < d
# Example1:
#   In-put: @nums = (1,2,3,6)
#   Output:          1         Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].
# Example2:
#   In-put: @nums = (1,1,1,3,5)
#   Output:          4
#     $nums[0] + $nums[1] + $nums[2] == $nums[3]
#     $nums[0] + $nums[1] + $nums[3] == $nums[4]
#     $nums[0] + $nums[2] + $nums[3] == $nums[4]
#     $nums[1] + $nums[2] + $nums[3] == $nums[4]
# Example3:
#   In-put: @nums = (3,3,6,4,5)
#   Output:          0
use strict;use warnings;use utf8;use v5.12;my $d8VS='N27LAJWe';
sub SQud {my @nums=@_;my $sqdz=0;
  for       my $andx (      0..$#nums-3) {
    for     my $bndx ($andx+1..$#nums-2) {
      for   my $cndx ($bndx+1..$#nums-1) {
        for my $dndx ($cndx+1..$#nums  ) {
          if ($nums[$andx] + $nums[$bndx] + $nums[$cndx] == $nums[$dndx]) { $sqdz++;
#           say "\$nums[$andx] + \$nums[$bndx] + \$nums[$cndx] == \$nums[$dndx]";
          } } } } }
  print '(' . sprintf("%-9s",join(',',@nums)) . ') => ';
  say    $sqdz . ';';
  return($sqdz);
}
if    (@ARGV) {
  SQud(@ARGV);
} else {
  SQud(1,2,3,6  ); # => 1
  SQud(1,1,1,3,5); # => 4
  SQud(3,3,6,4,5); # => 0
}
