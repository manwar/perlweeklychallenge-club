#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 295-2,
written by Robbie Hatley on Wed Nov 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 295-2: Jump Game
Submitted by: Mohammad Sajid Anwar
Write a script to find the minimum number of jumps to reach from
the first element to the last of a given array of integers,
@ints, such that $ints[$i] represents the maximum length of a
forward jump from the index $i. If the last element is
unreachable, then return -1.

Example 1:
Input:  @ints = (2, 3, 1, 1, 4)
Output: 2
Jump 1 step from index 0 then 3 steps from index 1 to the last
element.

Example 2:
Input:  @ints = (2, 3, 0, 4)
Output: 2

Example 3:
Input:  @ints = (2, 0, 0, 4)
Output: -1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem (like the first) lends itself to solution by recursion. My recursive subroutine first jumps
every allowable distance forward from the current position. Then for each new position it lands on, it
sends the corresponding new start location and jumps-so-far back through the subroutine, in a process of
"recursive segmentation".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of nonnegative integers, in proper Perl syntax, like so:
./ch-2.pl '([2, 1, 1, 1, 3, 1, 1, 1, 42],[2, 1, 1, 1, 2, 1, 1, 1, 42],[2, 1, 1, 1, 1, 1, 1, 1, 42]),[1,0,1]'
This program will attempt to jump forward from the 0th to last element of each inner array in the minimum
number of jumps, while obeying the restriction that each element specifies the maximum forward jump length
which may be executed from that element.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'min';
   sub jumps ($aref, $start=0, $jumps=0) {
      my @jumps = ();
      # If we've reached the end, no need to consider any further jumps,
      # just record the jumps we did to get here:
      if ($start == $#$aref) {
         push @jumps, $jumps;
      }
      # Otherwise, we need to explore the result of jumping forward from
      # the current start point by all allowable lengths:
      else {
         for my $jump (1..$aref->[$start]) {
            # First, do a sanity check:
            next if $start+$jump < 0 || $start+$jump > $#$aref;
            # RECURSE!!!
            push @jumps, jumps($aref, $start+$jump, $jumps+1);
         }
      }
      # If returning from the top level, return minimum number of jumps,
      # unless we couldn't reach end, in which case return -1:
      if (0 == $start) {
         if (0 == scalar(@jumps)) {return -1;}
         else {return min(@jumps);}
      }
      # Otherwise, return the list of number of jumps from here to end
      # which we've found via this sub-tree:
      else {
         return @jumps;
      }
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [2, 3, 1, 1, 4], # expected output: 2
   [2, 3, 0, 4],    # expected output: 2
   [2, 0, 0, 4],    # expected output: -1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $jumps = jumps($aref);
   say "Min jump = $jumps";
}
