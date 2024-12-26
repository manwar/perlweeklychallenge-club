#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 301-2,
written by Robbie Hatley on Mon Dec 23, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 301-2: Hamming Distance
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
return the sum of Hamming distances between all the pairs of the
integers in the given array of integers. The Hamming distance
between two integers is the number of places in which their
binary representations differ.

Example #1:
Input: @ints = (4, 14, 2)
Output: 6
Binary representation:
4  => 0100
14 => 1110
2  => 0010
  HammingDistance( 4, 14)
+ HammingDistance( 4,  2)
+ HammingDistance(14,  2)
= 2 + 2 + 2 = 6.

Example #2:
Input: @ints = (4, 14, 4)
Output: 4

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Firstly, I'll assume that "integers" means "non-negative integers", as negative integers have no predetmined
binary representation, as that's dependent on the encoding and bit-width used by one's CPU and programming
language.

That being stipulated, I'll use two subs: one called "H" to get the Hamming distance, and one called "H_sum"
to get the summation of the Hamming distances.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of non-negative integers, in proper Perl syntax, like so:
./ch-2.pl '([8137,0,7873,642],[37,61,18,111])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   sub H ($x, $y) {
      length((sprintf("%b", $x^$y)) =~ s/0//gr)
   }
   sub H_sum (@nums) {
      my $H_sum = 0;
      for    my $i ( 0 .. $#nums-1 ) {
         for my $j ( 1 .. $#nums-0 ) {
            $H_sum += H($nums[$i],$nums[$j])
         }
      }
      return $H_sum
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ( [4, 14, 2] , [4, 14, 4] );
#                  Expected outputs :        6            4

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @nums = @$aref;
   say "Numbers = (@nums)";
   my $hsum = H_sum(@nums);
   say "Hamming Sum = $hsum";
}
