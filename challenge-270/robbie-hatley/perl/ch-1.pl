#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 270-1,
written by Robbie Hatley on Mon May 20, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 270-1: Special Positions
Submitted by: Mohammad Sajid Anwar
You are given a m x n binary matrix. Write a script to return
the number of special positions in the given binary matrix.
A position (i, j) is called "special" if $matrix[i][j] == 1
and all other elements in the row i and column j are 0.

Example 1 input:
   [1, 0, 0],
   [0, 0, 1],
   [1, 0, 0],
There is only one special position (1, 2) as $matrix[1][2] == 1
and all other elements in row 1 and column 2 are 0.
Expected output: 1

Example 2 input:
   [1, 0, 0],
   [0, 1, 0],
   [0, 0, 1],
Special positions are (0,0), (1, 1) and (2,2).
Expected output: 3

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, simply count the row-sum and column-sum for each position, then count the number of
positions for which the position value, row-sum, and col-sum are all 1.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of m x n binary matrices, in proper Perl syntax, like so:
./ch-1.pl '([[0,0,1],[1,0,0],[0,0,0]],[[0,1,0],[1,0,0],[1,0,1]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

   use v5.38;
   use List::Util 'sum0';
   $" = ', ';

   # Is a given scalar a ref to an m x n binary matrix?
   sub is_binary_matrix ($matref) {
      'ARRAY' ne ref $matref and return 0; # Not a ref to an array?
      my $m = scalar($matref);
      0 == $m and return 1; # All 0x0 arrays are mxn binary matrices.
      my $n = scalar(@{$$matref[0]});
      for my $rowref (@$matref) {
         scalar(@$rowref) != $n and return 0; # Not rectangular?
         for my $element (@$rowref) {
            '0' ne $element && '1' ne $element and return 0; # Not binary?
         }
      }
      return 1; # Rectangular binary matrix.
   }

   # Return a row of a matrix:
   sub row ($matref, $i) {
      return @{$$matref[$i]};
   }

   # Return a column of a matrix:
   sub col ($matref, $j) {
      my @col;
      for my $rowref (@$matref) {
         push(@col, $$rowref[$j]);
      }
      return @col;
   }

   # How many "Special Positions" (according to the problem
   # definition) are in a given binary matrix?
   sub special_positions ($matref) {
      # Determine dimensions of matrix:
      my $m = scalar(@{ $matref   }); # Number of rows.
      my $n = scalar(@{$$matref[0]}); # Number of columns.

      # Get counts of "1" elements for each row:
      my @rowcounts = ();
      for ( my $i = 0 ; $i < $m ; ++$i ) {
         push(@rowcounts,sum0(row($matref,$i)));
      }

      # Get counts of "1" elements for each column:
      my @colcounts = ();
      for ( my $j = 0 ; $j < $n ; ++$j ) {
         push(@colcounts,sum0(col($matref,$j)));
      }

      # Tally and return number of elements for which element,
      # row-count, and col-count are all 1:
      my $count = 0;
      for         ( my $i = 0 ; $i < $m ; ++$i                 ) {
         for      ( my $j = 0 ; $j < $n ; ++$j                 ) {
            if    ( 1 == $matref->[$i]->[$j]                   ) {
               if ( 1 == $rowcounts[$i] && 1 == $colcounts[$j] ) {
                  ++$count;
               }
            }
         }
      }
      return $count;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [
      [1, 0, 0],
      [0, 0, 1],
      [1, 0, 0],
   ],
   # Expected output: 1

   # Example 2 input:
   [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1],
   ],
   # Expected output: 3
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $matref (@matrices) {
   say '';
   say 'Matrix = ';
   say "[@$_]" for @$matref;
   !is_binary_matrix($matref)
   and say 'Error: Not a binary matrix'
   and say 'Moving on to next matrix.'
   and next;
   my $nsp = special_positions($matref);
   say "Number of Special Positions = $nsp";
}
