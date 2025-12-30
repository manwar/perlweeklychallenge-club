#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 354-2,
written by Robbie Hatley on Tue Dec 30, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 354-2: Shift Grid
Submitted by: Mohammad Sajid Anwar
You are given m x n matrix and an integer, $k. Write a script to
right-shift the given matrix by $k positions.

Each shift follows these rules:

Rule 1: Element at grid[i][j] moves to grid[i][j + 1]. This means
every element moves one step to the right within its row.

Rule 2: Element at grid[i][n - 1] moves to grid[i + 1][0]
This handles the last column: elements in the last column of
row i wrap to the first column of the next row (i+1).

Rule 3: Element at grid[m - 1][n - 1] moves to grid[0][0]
This is the bottom-right corner: it wraps to the top-left corner.

See "INPUTS:" section below for example inputs and corresponding
expected outputs.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I first make note of the shape of the matrix, then flatten it into one long list,
then shift the list, then reformat it back to a matrix of the original dimensions.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a matrix (of any elements) followed by
an integer, in proper Perl syntax, like so:

./ch-2.pl '([[[8,4],[6,5]], -1],[[["z","g","q"],["l","p","w"]],2])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

   use v5.36;
   use utf8::all;

   $"=', ';

   # Flatten a matrix to an array:
   sub flatten ( $mref ) {
      my @out;
      foreach my $row (@$mref) {
         foreach my $ele (@$row) {
            push @out, $ele}}
      return @out}

   # Unflatten an array to a $m by $n matrix:
   sub unflatten ( $m, $n, @array, ) {
      my $mref = [];
      foreach my $row (0..$m-1) {
         push @$mref, []}
      foreach my $idx (0..$#array) {
         my $row = int($idx/$n);
         my $col = $idx%$n;
         $mref->[$row]->[$col] = $array[$idx]}
      return $mref}

   # Right-shift an array by any integer $x:
   sub shift_array ( $x, @array ) {
      my @out;
      my $n = scalar(@array);
      if ($x > 0) {
         push @out, @array[$n-$x..$n-1];
         push @out, @array[0..$n-$x-1]}
      elsif ($x < 0) {
         push @out, @array[(-$x)..$n-1];
         push @out, @array[0..(-$x)-1]}
      else {
         push @out, @array}
      return @out}

   # Right-shift a matrix by any integer $x:
   sub shift_matrix ( $x, $mref ) {
      my $m = scalar(@$mref);
      my $n = scalar(@{$$mref[0]});
      my @flat = flatten($mref);
      my @shft = shift_array($x, @flat);
      my $oref = unflatten($m, $n, @shft);
      return $oref}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @inputs = @ARGV ? eval($ARGV[0]) :
# Example inputs and corresponding expected outputs:
(
   # Example 1 input:
   [
      [
         [1, 2, 3],
         [4, 5, 6],
         [7, 8, 9],
      ],
      1,
   ],
   # Expected output:
   # 9, 1, 2
   # 3, 4, 5
   # 6, 7, 8

   # Example 2 input:
   [
      [
         [10, 20],
         [30, 40],
      ],
      1,
   ],
   # Expected output:
   # 40, 10
   # 20, 30

   # Example 3 input:
   [
      [
         [1, 2],
         [3, 4],
         [5, 6],
      ],
      1,
   ],
   # Expected output:
   # 6, 1
   # 2, 3
   # 4, 5

   # Example 4 input:
   [
      [
         [1, 2, 3],
         [4, 5, 6],
      ],
      5,
   ],
   # Expected output:
   # 2, 3, 4
   # 5, 6, 1

   # Example 5 input:
   [
      [
         [1, 2, 3, 4],
      ],
      1,
   ],
   # Expected output:
   # 4, 1, 2, 3
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $iref (@inputs) {
   say '';
   my $mref = $$iref[0];
   my $shft = $$iref[1];
   say 'Original matrix:';
   say "@$_" for @$mref;
   say "Amount to shift = $shft";
   my $sref = shift_matrix($shft, $mref);
   say 'Shifted matrix:';
   say "@$_" for @$sref;
}
