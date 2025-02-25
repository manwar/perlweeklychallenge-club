#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 310-1,
written by Robbie Hatley on Mon Feb 24, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 310-1: Arrays Intersection
Submitted by: Mohammad Sajid Anwar
You are given a list of arrays of integers. Write a script to
return the common elements in all the arrays.

Example #1:
Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
Output: (1, 4)

Example #2:
Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
Output: (2)

Example #3:
Input: $list = ( [1, 2, 3], [4, 5], [6] )
Output: ()

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll start by writing a subroutine that determines whether a given integer is in a given array of integers.
Then I'll write a sub that determines whether a given integer is in all of the given arrays.
Finally, I'll write a sub that determines the common elements between multiple arrays.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of no-more-than-20 arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([[1,3,8,17],[17,3,4,32]],[[8,6,5,9],[14,5,17,33],[-6,3,41,11,5,15]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::SomeUtils 'distinct';

   # Is a given integer in an array of integers?
   sub is_in_array ($scalar, $aref) {
      for my $integer (@$aref) {return 1 if $integer == $scalar}
      return 0;
   }

   # Is a given integer in all arrays of a set?
   sub is_in_all_arrays ($scalar, @arefs) {
      for my $aref (@arefs) {return 0 if !is_in_array($scalar, $aref)}
      return 1;
   }

   # What are the common integers between a set of arrays of integers?
   sub common_integers (@arefs) {
      my @common = ();
      for my $aref (@arefs) {
         my @array = @$aref;
         for my $integer (@array) {
            if (is_in_all_arrays($integer, @arefs)) {
               push @common, $integer;
            }
         }
      }
      return distinct @common;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @aarefs = @ARGV ? eval($ARGV[0]) :
(
   [
      [1, 2, 3, 4],
      [4, 5, 6, 1],
      [4, 2, 1, 3],
   ],                # Expected output: (1,4)
   [
      [1, 0, 2, 3],
      [2, 4, 5   ],
   ],                # Expected output: (2)
   [
      [1, 2, 3   ],
      [4, 5      ],
      [6         ],
   ],                # Expected output: ()
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aaref (@aarefs) {
   say '';
   my @arefs = @$aaref;
   say 'Array set:';
   for my $aref (@arefs) {
      say "[@$aref]";
   }
   my @common = common_integers(@arefs);
   say "Common integers = (@common)"
}
