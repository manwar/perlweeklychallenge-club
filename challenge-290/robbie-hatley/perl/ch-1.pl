#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 290-1,
written by Robbie Hatley on Tue Oct 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 290-1: "Double Exists"
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find if there exist two indices $i and $j such that:
1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]

Example 1:
Input: @ints = (6, 2, 3, 3)
Output: true
For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2:
Input: @ints = (3, 1, 4, 13)
Output: false

Example 3:
Input: @ints = (2, 1, 4, 2)
Output: true
For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
A pair of nested three-part loops will solve this easily.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([-7,1,4,18,3,-2],[-7,1,4,-14,3,-2])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   # Double, double, toil and trouble!
   sub DDTAT {
      my $aref = shift;
      for    ( my $i =    0   ; $i <= $#$aref-1 ; ++$i ) {
         for ( my $j = $i + 1 ; $j <= $#$aref-0 ; ++$j ) {
            if ( $$aref[$i] == 2*$$aref[$j]
              || $$aref[$j] == 2*$$aref[$i] ) {
               return 'True.';
            }
         }
      }
      return 'False.';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([6, 2, 3, 3] , [3, 1, 4, 13] , [2, 1, 4, 2]);
#                  Expected outputs :       true           false          true
# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my $ddtat = DDTAT($aref);
   print "Array = (@$aref)  Double exists? $ddtat\n";
}
