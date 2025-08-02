#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 296-2,
written by Robbie Hatley on Tue Nov 19, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 296-2: Matchstick Square
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find if it is possible to make one square using the sticks as in
the given array @ints where $ints[i] is the length of ith stick.

Example 1
Input: @ints = (1, 2, 2, 2, 1)
Output: true
Top: $ints[1] = 2
Bottom: $ints[2] = 2
Left: $ints[3] = 2
Right: $ints[0] and $ints[4] = 2

Example 2
Input: @ints = (2, 2, 2, 4)
Output: false

Example 3
Input: @ints = (2, 2, 2, 2, 4)
Output: false

Example 4
Input: @ints = (3, 4, 1, 4, 3, 1)
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem essentially asks if a set of integers can be partitioned into 4 partitions with the sums of the
integers in the 4 partitions being equal. I can envision ways of doing this involving imposing segmentation
patterns onto permutations, but those are going to have very-high big-O. Better will be to make a recursive
subroutine that generates all size-m non-empty partitions of a set of n elements. It should ensure that the
size of each partition is >= the size of the partition to its right in order to minimize (but not eliminate)
duplication of partitionings. I'll this use this subroutine to make all 4-partitions of our set of sticks,
and see if any of those partitionings have all 4 partitions summing equally. (Note: For a simpler-and-faster
version of this program, see file "ch-2.pl" in this directory, which uses CPAN module
"Algorithm::Combinatorics" instead of doing partitionings manually.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-2.pl '([1,2,3,4,5,6,7],[1,2,3,4,5,6,8])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'sum0';
   use Math::Combinatorics;
   $"=', ';

   # Return all possible partitionings of a set of n elements into m partitions, with m <= n:
   sub rhpartition ($m, @set) {#,
      my $n = scalar(@set);
      # If $m is 1, there is only one way to partition this set: a single partition containing all elements:
      if ( 1 == $m ) {return [[@set]]}
      # Otherwise, make a 3D array to hold all possible partitionings (including some which are permutative
      # duplicates of each other) of our input set:
      my @partitionings;
      # For each possible first partition, push all partitionings starting with that partition onto
      # @partitionings:
      foreach my $ps (1..$n-$m+1) {                    # for each possible first-partition size
         my @index_combos = combine($ps,0..$#set);     # All possible $ps-element subsets of indexes of @set.
         foreach my $index_combo (@index_combos) {     # for each index-combo reference
            my @first;                                 # first partition
            my @remai;                                 # remainder, to be partitioned
            I:foreach my $i (0..$#set) {                        # for each index of set
               J:foreach my $j (@$index_combo) {                # for each index of index combo
                  if ($i == $j) {push @first, $set[$i];next I}  # if equal, push to @first
               }
               push @remai, $set[$i];                           # otherwise, push to @remai
            }
            # Get all smaller (size $m-1) partitionings of the unsliced remainder of @copy:
            my @smaller_partitionings = rhpartition($m-1,@remai);
            # For each smaller (size $m-1) partitioning of @remai, make a larger (size $m) partitioning
            # with @first as first partition:
            foreach my $smaller_partitioning (@smaller_partitionings) {
               push @partitionings, [\@first, @$smaller_partitioning];
            }
         }
      }
      return @partitionings;
   }

   # Do the partitions of a given partitioning of a set have equal sums?
   sub equal {
      my @partitions = @_;
      my $reference  = sum0(@{$partitions[0]});
      foreach my $partition (@partitions) {
         if (sum0(@{$partition}) != $reference) {
            return 0;
         }
      }
      return 1;
   }

   # Can we make a square out of a pile of sticks?
   sub square (@array) {
      my @partitionings = rhpartition(4,@array);
      foreach my $partitioning (@partitionings) {
         my @partitions = @$partitioning;
         if (equal(@partitions)) {
            say 'I can make a square from this partitioning of the given array:';
            say join(', ', map {'['."@$_".']'} @partitions);
            return;
         }
      }
      say 'Sorry, I couldn\'t make a square from that array.';
      return;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
# Example inputs:
(
   [1, 2, 2, 2, 1],    # Expected output: true
   [2, 2, 2, 4],       # Expected output: false
   [2, 2, 2, 2, 4],    # Expected output: false
   [3, 4, 1, 4, 3, 1], # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array = @{$aref};
   say "Array = [@array]";
   square(@array);
}
