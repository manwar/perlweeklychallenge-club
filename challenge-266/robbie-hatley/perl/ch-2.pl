#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 266-2,
written by Robbie Hatley on Mon Apr 22, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 266-2: X Matrix
Submitted by: Mohammad Sajid Anwar
You are given a square matrix, $matrix. Write a script to find
if the given matrix is X Matrix. A square matrix is an X Matrix
if all the elements on the main diagonal and antidiagonal are
non-zero and everything else are zero.

Example 1:
Input: $matrix = [1, 0, 0, 2],
                 [0, 3, 4, 0],
                 [0, 5, 6, 0],
                 [7, 0, 0, 1],
Output: true

Example 2:
Input: $matrix = [1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9],
Output: false

Example 3:
Input: $matrix = [1, 0, 2],
                 [0, 3, 0],
                 [4, 0, 5],
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of checking the indices. If "n" is the size of the matrix, then:
The "main" diagonal is given by j =   i
The "anti" diagonal is given by j = n-1-i
Just structure the matrix as an array of arrays, then test each element to make sure that they're all
non-zero if on one of the diagonals, or zero otherwise.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays, with each inner array of arrays being a square array of integers,
in proper Perl syntax, like so:
./ch-2.pl '([[8,0,32],[-2,0,17],[5,0,-27]],[[-17,0,33],[0,21,0],[-4,0,22]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;

# Is a given scalar an integer?
sub is_int ($x) {return $x =~ m/^-[1-9]\d*|0|[1-9]\d*$/;}

# Is a given scalar a reference to a square array of integers?
sub is_square ($mref) {
   'ARRAY' ne ref $mref and return 0;
   my $n = scalar @$mref;
   $n < 1 and return 0;
   for my $row (@$mref) {
      'ARRAY' ne ref $row and return 0;
      scalar(@$row) != $n and return 0;
      for my $element (@$row) {
         is_int($element) or return 0;
      }
   }
   return 1;
}

# Is a given square matrix of integers an X matrix?
sub is_x ($mref) {
   # Return 0 if any element does not obey the rules for an X matrix:
   my $n = scalar(@$mref);
   for    my $i (0..$n-1) {
      for my $j (0..$n-1) {
         # Check main diagonal:
         if ($j == $i) {
            $mref->[$i]->[$j] != 0 or return 0;
         }
         # Check anti diagonal:
         elsif ($j == $n-1-$i) {
            $mref->[$i]->[$j] != 0 or return 0;
         }
         # Check everything else:
         else {
            $mref->[$i]->[$j] != 0 and return 0;
         }
      }
   }
   # If we haven't returned 0 yet, this is an X matrix, so return 1:
   return 1;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      [1, 0, 0, 2],
      [0, 3, 4, 0],
      [0, 5, 6, 0],
      [7, 0, 0, 1],
   ],
   # Expected Output: true

   # Example 2 Input:
   [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
   ],
   # Expected Output: false

   # Example 3 Input:
   [
      [1, 0, 2],
      [0, 3, 0],
      [4, 0, 5],
   ],
   # Expected Output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $mref (@matrices) {
   say '';
   say 'Matrix:';
   for my $row (@$mref) {
      say '[', join(', ', @$row), ']';
   }
   if (!is_square($mref)) {
      say 'Error: Not a square matrix of integers.';
      say 'Moving on to next matrix.';
      next;
   }
   is_x($mref) and say 'IS an X matrix.'
               or  say 'ISN\'T an X matrix.';
}
