#!/usr/bin/perl
# Given a list of ints, find subsequence that respects Pattern 132. Return empty array if none found. i < j < k && a[i] < a[k] < a[j];
# Example 1:
#   Input : @list = (3, 1, 4, 2)
#   Output: (1, 4, 2) respect the Pattern 132.
# Example 2:
#   Input : @list = (1, 2, 3, 4)
#   Output: () since no subsequence can be found.
# Example 3:
#   Input : @list = (1, 3, 2, 4, 6, 5)
#   Output: (1, 3, 2) if more than one subsequence found then return the first.
# Example 4:
#   Input : @list = (1, 3, 4, 2)
#   Output: (1, 3, 2)
use strict;use warnings;use utf8;use v5.10;my $d8VS='MCMLB43P';
sub P132 {my @ilst=@_; # Last week, I treated output comments as to be printed.
  print '(' . sprintf("%-16s",join(', ',@ilst)) . ') => '; # This week, I just print input.
  for       my $i (     0..($#ilst-2)){
    for     my $j (($i+1)..($#ilst-1)){
      if    ($ilst[$i] < $ilst[$j]){
        for my $k (($j+1).. $#ilst   ){
          if($ilst[$i] < $ilst[$k] && $ilst[$k] < $ilst[$j]){
            say  "($ilst[$i], $ilst[$j], $ilst[$k]);";
            return($ilst[$i], $ilst[$j], $ilst[$k]);
          }
        }
      }
    }
  } say "();";
  return();
}
if(@ARGV){
  P132(@ARGV);
}else{
  P132(3, 1, 4, 2);
  P132(1, 2, 3, 4);
  P132(1, 3, 2, 4, 6, 5);
  P132(1, 3, 4, 2);
}
