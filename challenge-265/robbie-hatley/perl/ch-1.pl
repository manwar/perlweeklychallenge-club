#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 265-1,
written by Robbie Hatley on Mon Apr 15, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 265-1: 33% Appearance
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find an integer in the given array that appeared 33% or more.
If more than one found, return the smallest. If none found,
then return undef.

Example 1:
Input: @ints = (1,2,3,3,3,3,4,2)
Output: 3
1 appeared 1 times.
2 appeared 2 times.
3 appeared 4 times.
3 appeared 50% (>33%) in the given array.

Example 2:
Input: @ints = (1,1)
Output: 1
1 appeared 2 times.
1 appeared 100% (>33%) in the given array.

Example 3:
Input: @ints = (1,2,3)
Output: 1
1 appeared 1 times.
2 appeared 1 times.
3 appeared 1 times.
Since all three appeared 33.3% (>33%) in the given array.
We pick the smallest of all.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll make a hash %a to keep track of the abundances of the integers in @ints. I'll then start iterating
through the forward-numeric-sorted keys of %a; if the value corresponding to any key is at least 0.33 times
the size of @ints i'll stop iterating and return that value; otherwise I'll return undef.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax:
./ch-1.pl '([3,3,3,1,1,1,2,2,2],[14,3,27,6])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use strict;
use warnings;
# Return smallest int which makes up 33% of the ints in an array of ints:
sub a33 (@ints) { # "a33" = "appears 33% or more"
   # Make a hash of abundances:
   my %a;
   # Increment a counter for each key, autovivifying as necessary:
   foreach my $int (@ints) {
      ++$a{$int};
   }
   # Set comparison limit to 0.33 times the size of @ints:
   my $limit = 0.33 * scalar(@ints);
   # Iterate through the forward-numeric-sorted keys of %a;
   # if any corresponding value is >= $limit, return it:
   foreach my $key (sort {$a<=>$b} keys %a) {
      if ( $a{$key} >= $limit ){
         return $key;
      }
   }
   # If we get to here, no "33% Appearance" was found, so return undef:
   return undef;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [1,2,3,3,3,3,4,2],
   # Expected Output: 3

   # Example 2 Input:
   [1,1],
   # Expected Output: 1

   # Example 3 Input:
   [1,2,3],
   # Expected Output: 1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @ints = @$aref;
   say '@Ints = (', join(', ', @ints), ')';
   my $smallest = a33(@ints);
   defined $smallest and say "Smallest \"33% Appearance\" int = $smallest"
   or say "No \"33% Appearance\" int was found.";
}
