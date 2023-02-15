#!/usr/bin/env raku
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
use v6;my $d8VS='N29LGtxT';
sub SQud {my @nums=@_;my $sqdz=0;
  for             0..@nums.elems-4 -> $andx {
    for     $andx+1..@nums.elems-3 -> $bndx {
      for   $bndx+1..@nums.elems-2 -> $cndx {
        for $cndx+1..@nums.elems-1 -> $dndx {
          if (@nums[$andx] + @nums[$bndx] + @nums[$cndx] == @nums[$dndx]) { $sqdz++;
#           say "\@nums[$andx] + \@nums[$bndx] + \@nums[$cndx] == \@nums[$dndx]";
          } } } } }
  print '(' ~ sprintf("%-9s",join(',',@nums)) ~ ') => ';
  say    $sqdz ~ ';';
  return($sqdz);
}
if    (@*ARGS) {
  SQud(@*ARGS);
} else {
  SQud(1,2,3,6  ); # => 1
  SQud(1,1,1,3,5); # => 4
  SQud(3,3,6,4,5); # => 0
}
