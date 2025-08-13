#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 334-2,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 334-2: Nearest Valid Point
Submitted by: Mohammad Sajid Anwar
You are given current location as two integers: x and y.You are
also given a list of points on the grid. A point is considered
"valid" if it shares either the same x-coordinate or the same
y-coordinate as the current location. Write a script to return
the index of the valid point that has the smallest Manhattan
distance to the current location. If multiple valid points are
tied for the smallest distance,return the one with the lowest
index. If no valid points exist, return -1.

The Manhattan distance between two points (x1, y1) and (x2, y2)
is calculated as: |x1 - x2| + |y1 - y2|

Example 1
Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
Output: 2
Valid points: [3, 1] (same x), [2, 4] (same y)
Manhattan distances:
    [3, 1] => |3-3| + |4-1| = 3
    [2, 4] => |3-2| + |4-4| = 1
Closest valid point is [2, 4] at index 2.

Example 2
Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
Output: 3
Valid points: [2, 3], [1, 5], [2, 5]
Manhattan distances:
    [2, 3] => 2
    [1, 5] => 1
    [2, 5] => 0
Closest valid point is [2, 5] at index 3.

Example 3
Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
Output: -1
No point shares x or y with (1, 1).

Example 4
Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
Output: 0
Valid points: all of them
Manhattan distances:
    [0, 1] => 1
    [1, 0] => 1
    [0, 2] => 2
    [2, 0] => 2
Tie between index 0 and 1, pick the smaller index: 0

Example 5
Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
Output: 0
Valid points: all of them
    [5, 6] => 1
    [6, 5] => 1
    [5, 4] => 1
    [4, 5] => 1
All tie, return the one with the lowest index: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll write three subs:
sub md # Manhattan Distance
sub iv # Is Valid point?
sub nv # Nearest Valid point

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of "the [x,y] coordinates of a 'current' point followed by an array of [x,y]
coordinates of some other points", in proper Perl syntax, like so:
./ch-2.pl '([[3,4],[[3,8],[-42,4]]], [[1,2],[[3,4],[4,5],[-8,2],[1,3]]])'
The first point of each set will be construed as "current point" and the remainder will be sifted-through
looking for "lowest-index nearest valid point".

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use POSIX 'Inf';

   # Manhattan Distance of p relative to c:
   sub md ($p, $c) {
      abs($p->[0]-$c->[0])+abs($p->[1]-$c->[1])}

   # Is p a Valid point relative to c?
   sub iv ($p, $c) {
      $p->[0]==$c->[0]||$p->[1]==$c->[1]}

   # index of lowest-index Nearest Valid point:
   sub nv ($c, $a) { # c = current, a = array
      my $ni = -1;  # idx of nearest valid point
      my $nd = Inf; # dst of nearest valid point
      # Find lowest-index nearest valid point:
      for my $idx (0..$#$a) {  # For each index,
         my $p = $a->[$idx];   #   get point.
         if (iv($p,$c)) {      #   If point is valid,
            my $d = md($p,$c); #     get distance.
            if ($d<$nd) {      #     If distance < min,
               $ni = $idx;     #       set new min idx
               $nd = $d}}}     #       set new min dst
      $ni}                     # Return min idx.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [[3,4], [[1, 2], [3, 1], [2, 4], [2, 3]]],
   # Expected output: 2

   # Example #2 inputs:
   [[2, 5], [[3, 4], [2, 3], [1, 5], [2, 5]]],
   # Expected output: 3

   # Example #3 inputs:
   [[1, 1], [[2, 2], [3, 3], [4, 4]]],
   # Expected output: -1

   # Example #4 inputs:
   [[0, 0], [[0, 1], [1, 0], [0, 2], [2, 0]]],
   # Expected output: 0

   # Example #5 inputs:
   [[5, 5], [[5, 6], [6, 5], [5, 4], [4, 5]]],
   # Expected output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $c = $aref->[0];
   my $a = $aref->[1];
   say "Current point = [@$c]";
   my @points = map {'[' . "@$_" . ']'} @$a;
   say "Other points  = @points";
   my $nv = nv($c, $a);
   say "Index of lowest-index nearest valid point = $nv";
}
