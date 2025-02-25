#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 293-2,
written by Robbie Hatley on Mon Oct 28, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 293-2: Boomerang
Submitted by: Mohammad Sajid Anwar
You are given an array of points (x,y). Write a script to find
out if the given points are a boomerang. A boomerang is a set
of three points that are all distinct and not in a straight line.

Example 1
Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true

Example 2
Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false

Example 3
Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true

Example 4
Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false

Example 5
Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false

Example 6
Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
There are a number of different approaches one could take to this. Two approaches are to compare slopes or
compare angles. However, I note that every three points define a (possibly-degenerate) triangle, and every
triangle has a (possibly-zero) area given by Heron's Formula, which says that given a triangle with sides
having lengths a,b,c, if we let s = (a+b+c)/2 then the area A = sqrt(s*(s-a)*(s-b)*(s-c)). If a triangle's
area is at least 1/10000 of the maximum area a triangle of that semiperimeter can have, then I'll consider
that triangle to be a "boomerang". (The max area of a triangle with semiperimeter s is when the triangle
is equilateral, which gives max_area = s**2/sqrt(27).)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of six real numbers, in proper Perl syntax, like so:
./ch-2.pl '([2,8,4,16,8,31.9994],[8.6,2.3,7.9,16.4,0.8,4.1])'
Each set of 6 numbers will be construed as the coordinates of 3 points, [$x1,$y1,$x2,$y2,$x3,$y3].

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # What is the distance between two points?
   sub dst ($x1,$y1,$x2,$y2) {sqrt(($x1-$x2)**2+($y1-$y2)**2)}

   # What are the semiperimeter and area of a triangle?
   sub Heron ($x1,$y1,$x2,$y2,$x3,$y3) {
      my $a = dst($x1,$y1,$x2,$y2);
      my $b = dst($x2,$y2,$x3,$y3);
      my $c = dst($x3,$y3,$x1,$y1);
      my $s = ($a+$b+$c)/2;
      my $A = sqrt($s*($s-$a)*($s-$b)*($s-$c));
      return($s,$A);
   }

   # Is a set of three points a boomerang?
   sub Boomerang ($x1,$y1,$x2,$y2,$x3,$y3) {
      # What are the semiperimeter and area of the triangle?
      my ($s,$A) = Heron($x1,$y1,$x2,$y2,$x3,$y3);
      # What is the max area a triangle of semiperimeter s can have?
      my $max_area = $s**2/sqrt(27);
      # This is a boomerang if $A is at least 1/10000 of $max_area:
      $A >= $max_area/10_000;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 1, 2, 3, 3, 2], # Expected output: true
   [1, 1, 2, 2, 3, 3], # Expected output: false
   [1, 1, 1, 2, 2, 3], # Expected output: true
   [1, 1, 1, 2, 1, 3], # Expected output: false
   [1, 1, 2, 1, 3, 1], # Expected output: false
   [0, 0, 2, 3, 4, 5], # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
use Scalar::Util 'looks_like_number';
SIX: for my $aref (@arrays) {
   # Ignore current element of @arrays unless it's a ref to a list of 6 real numbers in decimal ASCII:
   next SIX if 'ARRAY' ne ref $aref;
   next SIX if 6 != scalar (@$aref);
   for (@$aref) {next SIX if !looks_like_number $_}
   # Print current set of 6 numbers, and state whether they constitute a boomerang:
   say '';
   my ($x1,$y1,$x2,$y2,$x3,$y3) = @$aref;
   my $boom = Boomerang($x1,$y1,$x2,$y2,$x3,$y3) ? 'True.' : 'False.';
   say "Points = [$x1,$y1],[$x2,$y2],[$x3,$y3]";
   say "Boomerang? $boom";
}
