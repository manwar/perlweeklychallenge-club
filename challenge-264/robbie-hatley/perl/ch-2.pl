#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 264-2,
written by Robbie Hatley on Mon Apr 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 264-2: Target Array
Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers, @source and @indices.
The @indices can only contains integers 0 <= i < size of @source.
Write a script to create target array by inserting at index
$indices[i] the value $source[i].

Example 1:
Input: @source  = (0, 1, 2, 3, 4)
       @indices = (0, 1, 2, 2, 1)
Output: (0, 4, 1, 3, 2)
@source  @indices  @target
0        0         (0)
1        1         (0, 1)
2        2         (0, 1, 2)
3        2         (0, 1, 3, 2)
4        1         (0, 4, 1, 3, 2)

Example 2:
Input: @source  = (1, 2, 3, 4, 0)
       @indices = (0, 1, 2, 3, 0)
Output: (0, 1, 2, 3, 4)
@source  @indices  @target
1        0         (1)
2        1         (1, 2)
3        2         (1, 2, 3)
4        3         (1, 2, 3, 4)
0        0         (0, 1, 2, 3, 4)

Example 3:
Input: @source  = (1)
       @indices = (0)
Output: (1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is one of those few Weekly Challenges where Task 2 is simpler than Task 1 (usually it's the other way
around). I'll solve this problem by using Perl's built-in "splice" feature to "splice" desired elements from
the "source" array into the target array being constructed, using the indices from the "indices" array to
specify insertion points.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of integers, with the second array of each inner pair being
insertion indices for the first array, in proper Perl syntax, like so:
./ch-2.pl '([[18,32,74],[0,0,0,]],[[18,32,74],[0,1,2]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use strict;
use warnings;
sub target_array ($s, $i) {
   my @t = ();
   for ( my $ii=0 ; $ii <= $#$s ; ++$ii ) {
      splice @t, $$i[$ii], 0, $$s[$ii];
   }
   return @t;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      [0, 1, 2, 3, 4],
      [0, 1, 2, 2, 1],
   ],
   # Expected Output: (0, 4, 1, 3, 2)

   # Example 2 Input:
   [
      [1, 2, 3, 4, 0],
      [0, 1, 2, 3, 0],
   ],
   # Expected Output: (0, 1, 2, 3, 4)

   # Example 3 Input:
   [
      [1],
      [0],
   ],
   # Expected Output: (1)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say 'Source  array = (', join(', ', @{$aref->[0]}), ')';
   say 'Indices array = (', join(', ', @{$aref->[1]}), ')';
   my @target = target_array($aref->[0], $aref->[1]);
   say 'Target  array = (', join(', ', @target      ), ')';
}
