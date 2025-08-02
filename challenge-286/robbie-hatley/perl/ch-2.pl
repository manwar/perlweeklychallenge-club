#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 286-2,
written by Robbie Hatley on Wed Sep 11, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 286-2: Order Game
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, whose length is a
power of 2. Write a script to play the order game (min and max)
and return the last element.

Example 1
Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
Output: 1
Operation 1:
min(2, 1) = 1
max(4, 5) = 5
min(6, 3) = 3
max(0, 2) = 2
Operation 2:
min(1, 5) = 1
max(3, 2) = 3
Operation 3:
min(1, 3) = 1

Example 2
Input: @ints = (0, 5, 3, 2)
Output: 0
Operation 1:
min(0, 5) = 0
max(3, 2) = 3
Operation 2:
min(0, 3) = 0

Example 3
Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
Output: 2
Operation 1:
min(9, 2) = 2
max(1, 4) = 4
min(5, 6) = 5
max(0, 7) = 7
min(3, 1) = 1
max(3, 5) = 5
min(7, 9) = 7
max(0, 8) = 8
Operation 2:
min(2, 4) = 2
max(5, 7) = 7
min(1, 5) = 1
max(7, 8) = 8
Operation 3:
min(2, 7) = 2
max(1, 8) = 8
Operation 4:
min(2, 8) = 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I could use one of the "pairwise" functions from one of the "List::Xxxxxxx" CPAN modules, but in this case
it's simpler to use recursion, reducing the "condensed" size of the list by a factor of 2 at each level.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax. Each inner array should have a length which
is a power of 2. For example:
./ch-2.pl '([1,2,3,4,5,6,7,8],[8,7,6,5,4,3,2,1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:
use List::Util qw( min max );
sub condense {
   my @array = @_;
   my @condensed;
   my $max = 0;
   for ( my $i = 0 ; $i <= $#array-1 ; $i += 2 ) {
      $max
      ? push(@condensed, max($array[$i],$array[$i+1]))
      : push(@condensed, min($array[$i],$array[$i+1]));
      $max = !$max;
   }
   1 == scalar(@condensed)
   ? return $condensed[0]
   : return condense(@condensed);
}


# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [2, 1, 4, 5, 6, 3, 0, 2],
   [0, 5, 3, 2],
   [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8],
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my @array = @$aref;
   my $condensed = condense(@array);
   print "\n";
   print "Array = (@array)\n";
   print "Order-Game Result = $condensed\n";
}
