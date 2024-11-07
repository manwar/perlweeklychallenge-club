#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 294-1,
written by Robbie Hatley on Wed Nov 06, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 294-1: Consecutive Sequence
Submitted by: Mohammad Sajid Anwar
You are given an unsorted array of integers, @ints. Write a
script to return the length of the longest consecutive elements
sequence. Return -1 if none found. The algorithm must run in O(n)
time.

Example 1:
Input: @ints = (10, 4, 20, 1, 3, 2)
Output: 4
The longest consecutive sequence (1, 2, 3, 4).
The length of the sequence is 4.

Example 2:
Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
Output: 9

Example 3:
Input: @ints = (10, 30, 20)
Output: -1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I could first sort the array, but that would be O(n*log(n)), not O(n). Faster will be to make a hash and look
for subsequences in that.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([-4,7,82,16,4] , [-4,7,82,-3,8,16,6,4])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.16;

   # Determine max consecutive-subsequence length
   # within an array of integers:
   sub maximum_consecutive_subsequence_length {
      # Make a hash:
      my %hash; for (@_) {++$hash{$_};}
      # Declare vars for begin, end, length, and max:
      my $beg = 0;my $end = 0;my $len = 0;my $max = 0;
      # Examine each element of the input array to see if it's
      # the beginning of a consecutive subsequence:
      for my $x (@_) {
         # Move on to next array element if $x-1 is in hash:
         next if $hash{$x-1};
         # We're at the beginning of a new consecutive subsequence,
         # so set $beg and $end to here:
         $beg = $x;$end=$x;
         # Find the end:
         ++$end while $hash{$end};
         # Get the length:
         $len = $end - $beg;
         # Update $max if $len is greater than $max:
         if ( $len > $max ) {$max = $len;}
      }
      # Return maximum consecutive subsequence length,
      # unless it's <2 in which case return -1:
      if ($max > 1) {return $max;} else {return -1;}
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [10, 4, 20, 1, 3, 2],           # Expected output = 4
   [0, 6, 1, 8, 5, 2, 4, 3, 0, 7], # Expected output = 9
   [10, 30, 20],                   # Expected output = -1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @a = @$aref;
   my $m = maximum_consecutive_subsequence_length(@a);
   say "Array = (@a)";
   say "Max consecutive-subsequence length = $m";
}
