#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 354-1,
written by Robbie Hatley on Tue Dec 30, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 354-1: Min Abs Diff
Submitted by: Mohammad Sajid Anwar
You are given an array of distinct integers. Write a script to
find all pairs of elements with the minimum absolute difference.
Rules (a,b):
1: a, b are from the given array.
2: a < b
3: b - a = min abs diff any two elements in the given array

See "INPUTS:" section below for example inputs and corresponding
expected outputs.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I make a hash of all possible pairs ($x,$y) keyed by abs($x-$y), then I simply return
those pairs associated with the minimum key. The "min" function from "List::Util" is handy for this.
I also sort elements within each pair in ascending order before hashing, and I sort the returned pairs in
ascending order of first element.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of unique integers, in proper Perl syntax, like so:

./ch-1.pl '([1,7,19,5,10,3,36],[24,84,64,4,104,44,-16])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'min';

   $"=', ';

   # Min Abs Diff:
   sub mad ( $aref ) {
      my %pairs;
      my $n = scalar(@$aref);
      foreach my $i (0..$n-2) {
         my $x = $$aref[$i];
         foreach my $j ($i+1..$n-1) {
            my $y = $$aref[$j];
            my $dist = abs($x-$y);
            push @{$pairs{$dist}}, [sort {$a<=>$b} ($x, $y)]}}
      sort {$$a[0]<=>$$b[0]} @{$pairs{min keys %pairs}}}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
# Example inputs and corresponding expected outputs:
(
   # Example #1 input:
   [4, 2, 1, 3],
   # Expected output: [1, 2], [2, 3], [3, 4]

   # Example #2 input:
   [10, 100, 20, 30],
   # Expected output: [10, 20], [20, 30]

   # Example #3 input:
   [-5, -2, 0, 3],
   # Expected output: [-2, 0]

   # Example #4 input:
   [8, 1, 15, 3],
   # Expected output: [1, 3]

   # Example #5 input:
   [12, 5, 9, 1, 15],
   # Expected output: [9, 12], [12, 15]
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   say 'Min Abs Diff pairs = ', join ', ', map {"[@$_]"} mad($aref);
}
