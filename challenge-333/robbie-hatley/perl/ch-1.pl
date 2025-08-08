#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 333-1,
written by Robbie Hatley on Mon Aug 04, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 333-1: Straight Line
Submitted by: Mohammad Sajid Anwar
You are given a list of co-ordinates. Write a script to find out
if the given points make a straight line.

Example 1
Input: @list = ([2, 1], [2, 3], [2, 5])
Output: true

Example 2
Input: @list = ([1, 4], [3, 4], [10, 4])
Output: true

Example 3
Input: @list = ([0, 0], [1, 1], [2, 3])
Output: false

Example 4
Input: @list = ([1, 1], [1, 1], [1, 1])
Output: true

Example 5
Input: @list = ([1000000, 1000000],
                [2000000, 2000000],
                [3000000, 3000000])
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll consider points A, B, C to be collinear if-and-only-if one of the following three things is true:
1. Two-or-more of the points are less than one billionth apart.
2. The slopes of all three sides of △ABC are all infinite (indicated by POSIX "Inf").
3. The slopes of all three sides of △ABC are less than one billionth apart.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of three arrays of two real numbers, in proper Perl syntax, like so:

./ch-1.pl '([[1.1, 2.2], [2.2, 3.3], [3.3, 4.4]], [[4.7, 6.5], [-5.2, 16.3], [-3.1, -42.3]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use POSIX 'Inf';

   # What is the distance between two points?
   sub dist ($A, $B) {
      my $Δx = $B->[0]-$A->[0];
      my $Δy = $B->[1]-$A->[1];
      sqrt($Δx**2+$Δy**2)}

   # What is the slope between two points?
   sub slope ($A, $B) {
      my $Δx = $B->[0]-$A->[0];
      my $Δy = $B->[1]-$A->[1];
      # If abs(Δx) is less than one billionth, slope is "Inf";
      # otherwise, slope is Δy/Δx:
      (abs($Δx) < 1E-9) ? Inf : $Δy/$Δx}

   # Are three points collinear to within one part per billion?
   sub colli ($A, $B, $C) {
      # If any two points are less than one billionth from each other,
      # then consider them to be the "same" point,
      # and hence consider all three points to be collinear:
      if (dist($A,$B)<1E-9 || dist($B,$C)<1E-9 || dist($C,$A)<1E-9) {
         return "These three points ARE collinear."}

      # Get the slopes of the three sides of △ABC:
      my $sAB = slope($A, $B);
      my $sBC = slope($B, $C);
      my $sCA = slope($C, $A);

      # If these three slopes are all "Inf", then these three points
      # are on the same vertical line and hence collinear:
      if (Inf == $sAB && Inf == $sBC && Inf == $sCA) {
          return "These three points ARE collinear."}

      # If all three slopes are the same to within one billionth,
      # consider these three points to be collinear:
      if (abs($sAB-$sBC)<1E-9 && abs($sBC-$sCA)<1E-9 && abs($sCA-$sAB)<1E-9) {
          return "These three points ARE collinear."}

      # Otherwise, points A, B, and C are NOT collinear:
      return "These three points are NOT collinear."}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [[2, 1], [2, 3], [2, 5]],
   # Expected output: "These three points ARE collinear."

   # Example 2 input:
   [[1, 4], [3, 4], [10, 4]],
   # Expected output: "These three points ARE collinear."

   # Example 3 input:
   [[0, 0], [1, 1], [2, 3]],
   # Expected output: "These three points are NOT collinear."

   # Example 4 input:
   [[1, 1], [1, 1], [1, 1]],
   # Expected output: "These three points ARE collinear."

   # Example 5 input:
   [[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]],
   # Expected output: "These three points ARE collinear."
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $A = $aref->[0];
   my $B = $aref->[1];
   my $C = $aref->[2];
   my $Astring = '[' . $A->[0]  . ', ' . $A->[1]                    . ']';
   my $Bstring = '[' . $B->[0]  . ', ' . $B->[1]                    . ']';
   my $Cstring = '[' . $C->[0]  . ', ' . $C->[1]                    . ']';
   my $Pstring = '[' . $Astring . ', ' . $Bstring . ', ' . $Cstring . ']';
   say "Points = $Pstring";
   my $colli = colli($A, $B, $C);
   say $colli;
}
