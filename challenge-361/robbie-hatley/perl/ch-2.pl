#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 361-2,
written by Robbie Hatley on Sun Feb 22, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 361-2: Find Celebrity
Submitted by: Mohammad Sajid Anwar
You are given a binary matrix (m x n). Write a script to find
the celebrity, return -1 when none found. A celebrity is
someone, everyone knows and knows nobody.

(
   # Example 1 input:
   [
      [0, 0, 0, 0, 1, 0],  # 0 knows 4
      [0, 0, 0, 0, 1, 0],  # 1 knows 4
      [0, 0, 0, 0, 1, 0],  # 2 knows 4
      [0, 0, 0, 0, 1, 0],  # 3 knows 4
      [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
      [0, 0, 0, 0, 1, 0],  # 5 knows 4
   ],
   # Expected output: 4

   # Example 2 input:
   [
      [0, 1, 0, 0],        # 0 knows 1
      [0, 0, 1, 0],        # 1 knows 2
      [0, 0, 0, 1],        # 2 knows 3
      [1, 0, 0, 0],        # 3 knows 0
   ],
   # Expected output: -1

   # Example 3 input:
   [
      [0, 0, 0, 0, 0],     # 0 knows NOBODY
      [1, 0, 0, 0, 0],     # 1 knows 0
      [1, 0, 0, 0, 0],     # 2 knows 0
      [1, 0, 0, 0, 0],     # 3 knows 0
      [1, 0, 0, 0, 0],     # 4 knows 0
   ],
   # Expected output: 0

   # Example 4 input:
   [
      [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
      [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
      [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
      [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
      [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
      [1, 0, 1, 1, 0, 0],  # 5 knows 0, 2, 3
   ],
   # Expected output: 3

   # Example 5 input:
   [
      [0, 1, 1, 0],        # 0 knows 1 and 2
      [1, 0, 1, 0],        # 1 knows 0 and 2
      [0, 0, 0, 0],        # 2 knows NOBODY
      [0, 0, 0, 0],        # 3 knows NOBODY
   ],
   # Expected output: -1

   # Example 6 input:
   [
      [0, 0, 1, 1],        # 0 knows 2 and 3
      [1, 0, 0, 0],        # 1 knows 0
      [1, 1, 0, 1],        # 2 knows 0, 1 and 3
      [1, 1, 0, 0],        # 3 knows 0 and 1
   ],
   # Expected output: -1
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I simply look for a row of 0s at a vertical index $i such that all other rows have "1"
at vertical index $i. That's easily determined by applying sum0 to vertical slice $i; a celebrity will always
have a sum of ($i-1). (Celebrities can never be self-aware, because that would involve knowing someone. And
there can never be more than one celebrity, because that would violate "everyone knows them".)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of 0s and 1s, in proper Perl syntax, like so:

./ch-2.pl '([[1,0,1],[1,0,0],[0,1,1]],[[1,0,1],[0,1,1],[0,0,0]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'sum0';

   # Find celebrities:
   sub Celebrities ( $mref ) {
      # First ensure matrix is square:
      my $m = scalar(@$mref);
      for my $i (0..$m-1) {
         if ($m != scalar(@{$$mref[$i]})) {
            return "Error: Matrix not square.";
         }
      }

      # Make an array to hold our output:
      my @out;

      # For each row, determine if it's a celebrity:
      for my $i (0..$m-1) {
         if (0 == sum0(@{$$mref[$i]})) {
            if ($m-1 == sum0(map {$mref->[$_]->[$i]} 0..$m-1)) {
               push @out, $i;
            }
         }
      }
      if (0 == scalar(@out)) {push @out, -1}

      # Return output:
      @out;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [
      [0, 0, 0, 0, 1, 0],  # 0 knows 4
      [0, 0, 0, 0, 1, 0],  # 1 knows 4
      [0, 0, 0, 0, 1, 0],  # 2 knows 4
      [0, 0, 0, 0, 1, 0],  # 3 knows 4
      [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
      [0, 0, 0, 0, 1, 0],  # 5 knows 4
   ],
   # Expected output: 4

   # Example 2 input:
   [
      [0, 1, 0, 0],        # 0 knows 1
      [0, 0, 1, 0],        # 1 knows 2
      [0, 0, 0, 1],        # 2 knows 3
      [1, 0, 0, 0],        # 3 knows 0
   ],
   # Expected output: -1

   # Example 3 input:
   [
      [0, 0, 0, 0, 0],     # 0 knows NOBODY
      [1, 0, 0, 0, 0],     # 1 knows 0
      [1, 0, 0, 0, 0],     # 2 knows 0
      [1, 0, 0, 0, 0],     # 3 knows 0
      [1, 0, 0, 0, 0],     # 4 knows 0
   ],
   # Expected output: 0

   # Example 4 input:
   [
      [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
      [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
      [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
      [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
      [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
      [1, 0, 1, 1, 0, 0],  # 5 knows 0, 2, 3
   ],
   # Expected output: 3

   # Example 5 input:
   [
      [0, 1, 1, 0],        # 0 knows 1 and 2
      [1, 0, 1, 0],        # 1 knows 0 and 2
      [0, 0, 0, 0],        # 2 knows NOBODY
      [0, 0, 0, 0],        # 3 knows NOBODY
   ],
   # Expected output: -1

   # Example 6 input:
   [
      [0, 0, 1, 1],        # 0 knows 2 and 3
      [1, 0, 0, 0],        # 1 knows 0
      [1, 1, 0, 1],        # 2 knows 0, 1 and 3
      [1, 1, 0, 0],        # 3 knows 0 and 1
   ],
   # Expected output: -1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $mref (@matrices) {
   say '';
   say "Matrix = ";
   say "[@$_]" for @$mref;
   my @c = Celebrities($mref);
   say "Celebrities = (@c)";
}
