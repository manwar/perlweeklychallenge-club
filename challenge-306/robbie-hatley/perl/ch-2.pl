#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 306-2,
written by Robbie Hatley on Mon Jan 27, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 306-2: "Last Element"
Submitted by: Mohammad Sajid Anwar
You are given a array of integers, @ints. Write a script to play
a game where you pick two biggest integers in the given array,
say x and y. Then do the following:
a) if x == y then remove both from the given array
b) if x != y then remove x and replace y with (y - x)
At the end of the game, there is at most one element left.
Return the last element if found otherwise return 0.

Example #1:
Input: @ints = (3, 8, 5, 2, 9, 2)
Output: 1
Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
Step 2: pick 3 and 5 => (2, 2, 1, 2)
Step 3: pick 2 and 1 => (1, 2, 2)
Step 4: pick 2 and 1 => (1, 2)
Step 5: pick 1 and 2 => (1)

Example #2:
Input: @ints = (3, 2, 5)
Output: 0
Step 1: pick 3 and 5 => (2, 2)
Step 2: pick 2 and 2 => ()

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Since we're going to end up boiling each incoming array down to 1 or 0 elements, order doesn't matter, so I'll
start by doing reverse numeric sort on the array. And each time an element is replaced, I'll sort the array
again. That way, "the two biggest integers" will always be the first two elements. I'll then keep deleting and
replacing as specified in the problem description, except that if the two largest integers are equal, I'll
replace them with 0. That way, I'll always end up with exactly 1 integer left in the array (which may be
zero or non-zero), and I'll present that integer as the output.

By the way, I note that Example #1 doesn't obey the problem description's mandate "pick two biggest integers",
as Steps 4 and 5 both pick "2 and 1" when in either case the two biggest integers would have been "2 and 2".
The problem description doesn't specify "two biggest UNIQUE integers", so I elect to consider steps 4 and 5 of
Example #1 to be "in-error" rather than re-write the problem description.

I also note that by following the problem description as-written (ie, "the two biggest integers present,
whether unique or identical"), in Example 1 the answer 1 is also obtained, though in a very different way.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl '([-42,17,73,-84, 56],[-3,-2,-1,0,1,2,3]),[7,7,7,7,]'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;

   # Keep replacing the two largest integers in an array
   # with the absolute value of their difference until
   # only one integer is left, then return that integer:
   sub last_element ($aref) {
      my @array = @$aref;
      while (scalar(@array) > 1) {
         @array = sort {$b<=>$a} @array;
         my $y = shift @array;
         my $x = shift @array;
         unshift @array, $y-$x;}
      return $array[0];}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([3, 8, 5, 2, 9, 2],[3, 2, 5]);
# Expected outputs:                            1              0

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $l_e = last_element($aref);
   say "Last Element = $l_e";
}
