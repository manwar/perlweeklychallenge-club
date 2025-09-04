#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 337-2,
written by Robbie Hatley on Wed Sep 03, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 337-2: Count Odds
Submitted by: Mohammad Sajid Anwar
You are given the height h and width w of a matrix of zeros
and a list of 0-indexed positions (r,c) within the matrix.
Write a script which performs the following two action for
each given location [r,c]:
a) Increment by 1 all the cells on row r.
b) Increment by 1 all the cells on column c.
Then return the count of odd integers in the matrix.

Example #1:
Input: $h = 2, $w = 3, @locations = ([0,1],[1,1])
Output: 6

Example #2:
Input: $h = 2, $w = 2, @locations = ([1,1],[0,0])
Output: 0

Example #3:
Input: $h = 3, $w = 3, @locations = ([0,0],[1,2],[2,1])
Output: 0

Example #4:
Input: $h = 1, $w = 5, @locations = ([0,2],[0,4])
Output: 2

Example #5:
Input: $h = 4, $w = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
Output: 8

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
For a change, Task 2 in this challenge is much easier than Task 1, in that we simply need to do the things
mentioned in the program description:
1. Make a matrix of zeros of the given dimensions.
2. For each coordinate pair (r,c), increment row r and column c.
3. Count odds.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a pair of positive integers followed by
an array of [x,y] coordinates, in proper Perl syntax, like so:

./ch-2.pl '([3,7,[[0,0,],[1,1,],[2,2]]],[5,8,[[2,4],[5,7]]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   # Perform given operations on given matrix of zeros,
   # then return number of odd numbers:
   sub count_odds ($h,$w,@p) {
      my @matrix;
      for(0..$h-1){
         push @matrix, [(0)x$w]}
      for my $p (@p) {
         # Increment row $p->[0]:
         for (0..$w-1) {
            ++$matrix[$p->[0]]->[$_]}
         # Increment col $p->[1]:
         for (0..$h-1) {
            ++$matrix[$_]->[$p->[1]]}}
      # Count odds:
      my $co = 0;
      for my $y (0..$h-1) {
         for my $x (0..$w-1) {
            ++$co if 0 != $matrix[$y]->[$x] % 2}}
      # Return result:
      $co}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [2,3,[[0,1],[1,1]             ]], # Expected output: 6
   [2,2,[[1,1],[0,0]             ]], # Expected output: 0
   [3,3,[[0,0],[1,2],[2,1]       ]], # Expected output: 0
   [1,5,[[0,2],[0,4]             ]], # Expected output: 2
   [4,2,[[1,0],[3,1],[2,0],[0,1] ]], # Expected output: 8
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my $h = $aref->[0];
   my $w = $aref->[1];
   my @p = @{$aref->[2]};
   my @s = map {"[@$_]"} @p;
   my $c = count_odds($h,$w,@p);
   say "h=$h, w=$w, positions=(@s), count-of-odds=$c";
}
