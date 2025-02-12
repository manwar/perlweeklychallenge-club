#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 307-1,
written by Robbie Hatley on Mon Feb 03, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 307-1: Check Order
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
re-arrange the given array in an increasing order and return
the indices where it differs from the original array.

Example #1:
Input: @ints = (5, 2, 4, 3, 1)
Output: (0, 2, 3, 4)
Before: (5, 2, 4, 3, 1)
After : (1, 2, 3, 4, 5)
Difference at indices: (0, 2, 3, 4)

Example #2:
Input: @ints = (1, 2, 1, 1, 3)
Output: (1, 3)
Before: (1, 2, 1, 1, 3)
After : (1, 1, 1, 2, 3)
Difference at indices: (1, 3)

Example #3:
Input: @ints = (3, 1, 3, 2, 3)
Output: (0, 1, 3)
Before: (3, 1, 3, 2, 3)
After : (1, 2, 3, 3, 3)
Difference at indices: (0, 1, 3)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of numeric sort followed by compare.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([18,-42,36,5,17,84,-14],[-3,-2,-1,0,1,2,3],[2,8,18,14,24])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   sub check_order {
      my ($aref1, $aref2) = @_;
      my @different_indices = ();
      for ( my $i = 0 ; $i <= $#$aref1 && $i <= $#$aref2 ; ++$i ) {
         if ($$aref1[$i]!=$$aref2[$i]) {
            push @different_indices, $i;
         }
      }
      return @different_indices;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([5,2,4,3,1]  ,  [1,2,1,1,3]  ,  [3,1,3,2,3]);
#                  Expected outputs : (0, 2, 3, 4)        (1, 3)        (0, 1, 3)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   print "\n";
   my @original = @$aref;
   my @sorted   = sort {$a<=>$b} @original;
   my @indices  = check_order(\@original,\@sorted);
   print "Original array    = (@original)\n";
   print "Sorted   array    = (@sorted)\n";
   print "Indices differing = (@indices)\n";
}
