#! /usr/bin/perl

########################################################################################################################
# "/d/rhe/PWCC/203/ch-1.pl"
# Finds "Special Quadruplets" within arrays.
#
# By Robbie Hatley.
#
# Edit history:
# Fri Feb 10, 2023: Wrote it.
########################################################################################################################

# DESCRIPTION OF PROBLEM:

=pod

Task 1: Special Quadruplets
Submitted by: Mohammad S Anwar

Write a script to determine the number of "Special Quadruplets" in any given array of integers.
Given an array "nums" of integers, a "Special Quadruplet" is a slice nums[a,b,c,d] that satisfies the following 2 rules:
1) nums[a] + nums[b] + nums[c] == nums[d]
2) a < b < c < d

Example 1:   Input: (1,2,3,6)     Output: 1
Example 2:   Input: (1,1,1,3,5)   Output: 4
Example 3:   Input: (3,3,6,4,5)   Output: 0

=cut

# IO NOTES:
# NOTE: Input is from either a built-in array-of-arrays, or from @ARGV.
#       If from @ARGV, arguments should be a space-separated sequence of integers,
#       which will be interpreted as being a single array.
#
# NOTE: Output will be to STDOUT, and will be a printout of each array, followed by
#       the number of Special Quadruplets found, followed by printouts of those quadruplets.

# PRELIMINARIES:
use v5.36;
$"=", ";

# DEFAULT INPUT:
my @arrays = ( [1,2,3,6], [1,1,1,3,5], [3,3,6,4,5] );

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays=([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my @nums  = @{$_};
   my @quads = ();
   my ($a, $b, $c, $d) = (0,0,0,0);
   for (          $a =    0   ; $a <= $#nums - 3 ; ++$a ){
      for (       $b = $a + 1 ; $b <= $#nums - 2 ; ++$b ){
         for (    $c = $b + 1 ; $c <= $#nums - 1 ; ++$c ){
            for ( $d = $c + 1 ; $d <= $#nums - 0 ; ++$d ){
               if ( $nums[$a] + $nums[$b] + $nums[$c] == $nums[$d] ){
                  push @quads, [$a, $b, $c, $d];}}}}}
   my $nq = scalar @quads;
   say '';
   say "\@nums = (@nums)";
   say "number of Special Quadruplets = $nq :";
   say "\@nums[@{$_}] = (@nums[@{$_}])" for @quads;}