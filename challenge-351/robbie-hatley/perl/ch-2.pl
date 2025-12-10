#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 351-2,
written by Robbie Hatley on Mon Dec 08, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 351-2: Arithmetic Progression
Submitted by: Mohammad Sajid Anwar
You are given an array of numbers. Write a script to return true
if the given array can be re-arranged to form an arithmetic
progression, otherwise return false. A sequence of numbers is
called an arithmetic progression if the difference between any
two consecutive elements is the same.

Example 1
Input: @num = (1, 3, 5, 7, 9)
Output: true
Already AP with common difference 2.

Example 2
Input: @num = (9, 1, 7, 5, 3)
Output: true
The given array re-arranged like (1, 3, 5, 7, 9)
with common difference 2.

Example 3
Input: @num = (1, 2, 4, 8, 16)
Output: false
This is geometric progression and not arithmetic progression.

Example 4
Input: @num = (5, -1, 3, 1, -3)
Output: true
The given array re-arranged like (-3, -1, 1, 3, 5)
with common difference 2.

Example 5
Input: @num = (1.5, 3, 0, 4.5, 6)
Output: true
The given array re-arranged like (0, 1.5, 3, 4.5, 6)
with common difference 1.5.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Let @srt = sort {$a<=>$b} @num. Then if $num[$idx-0]-$num[$idx-1] != $num[$idx-1]-$num[$idx-2] for any
$idx > 1, return false; otherwise, return true.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '([1,0,3,8,7,9],[1,0,"rat",3,5,2,4])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use Scalar::Util 'looks_like_number';
   use List::Util 'max', 'sum0';

   # Is a given array of numbers an arithmetic progression?
   sub is_ap ($aref) {
      my @num = grep {looks_like_number($_)} @$aref;
      my @srt = sort {$a <=> $b} @num;
      for my $idx (2..$#srt) {
         if ($srt[$idx-0] - $srt[$idx-1] != $srt[$idx-1] - $srt[$idx-2]) {
            return 'False.'}}
      return 'True.'}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 3, 5, 7, 9],     # True.
   [9, 1, 7, 5, 3],     # True.
   [1, 2, 4, 8, 16],    # False.
   [5, -1, 3, 1, -3],   # True.
   [1.5, 3, 0, 4.5, 6], # True.
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $is_ap = is_ap($aref);
   say "Is arithmetic progression? $is_ap";
}
