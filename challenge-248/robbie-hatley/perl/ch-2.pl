#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:

This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:

Solutions in Perl for The Weekly Challenge 248-2.
Written by Robbie Hatley on Sat Dec 23, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 248-2: Submatrix Sum
Submitted by: Jorg Sommrey
Rephrased by: Robbie Hatley
Given a NxM matrix A of real numbers, write a script to construct
an (N-1)x(M-1) matrix B having elements that are the sum over the
2x2 submatrices of A,
b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

Example 1:

Input:   [1,  2,  3,  4],
         [5,  6,  7,  8],
         [9, 10, 11, 12]

Output:  [14, 18, 22],
         [30, 34, 38]

Example 2:

Input:   [1, 0, 0, 0],
         [0, 1, 0, 0],
         [0, 0, 1, 0],
         [0, 0, 0, 1]

Output:  [2, 1, 0],
         [1, 2, 1],
         [0, 1, 2]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The solution to task 248-2 is similar to that of 248-1, because we need only make an array of matrices
of numbers, then iterate over each mxn matrix with nested 3-part loops to make the smaller m-1xn-1 matrix
of the sums of the 2x2 subarrays of the original matrix.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:
./ch-2.pl "([[-42.1,17.3,-0.13],[7,14.4,-3.2],[-1.1,-2.2,-3.3]],[[-1,2],[-3,4],[-5,6]])"

Output is to STDOUT and will be each input matrix followed by the corresponding output matrix.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';
use Scalar::Util 'looks_like_number';

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $db = 0 ; # Debug? Set to 1 for yes, 0 for no.
our $t0     ; # Starting time.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Check for errors:
sub error ($aref) {
   'ARRAY' ne ref($aref) and return 'Error: $aref is not a reference to an array.';
   my $m = scalar(@$aref);
   $db and say "m = $m";
   $m < 1 and return 'Error: @$aref is empty.';
   for my $row (@$aref) {
      'ARRAY' ne ref($row) and return 'Error: @$aref is not an array of arrays.';
   }
   my $n = scalar(@{$$aref[0]});
   $db and say "n = $n";
   for my $row (@$aref) {
      scalar(@$row != $n) and return 'Error: @$aref is not an mxn matrix.';
   }
   for my $row (@$aref) {
      for my $element (@$row) {
         !looks_like_number($element) and return 'Error: @$aref is not a matrix of numbers.';
      }
   }
   return 'ok';
}

# Generate matrix of 2x2 submatrix sums:
sub matrix_of_2x2_submatrix_sums ($aref) {
   my @rows;
   my $m = scalar(@$aref);
   my $n = scalar(@{$$aref[0]});
   for    ( my $i = 0 ; $i < $m-1 ; ++$i ) {
      for ( my $j = 0 ; $j < $n-1 ; ++$j ) {
         $rows[$i]->[$j] =
           $aref->[$i+0]->[$j+0]
         + $aref->[$i+0]->[$j+1]
         + $aref->[$i+1]->[$j+0]
         + $aref->[$i+1]->[$j+1];
      }
   }
   return @rows;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input matrix:
   [
      [1,  2,  3,  4],
      [5,  6,  7,  8],
      [9, 10, 11, 12],
   ],
   # Expected Output:
   # [14, 18, 22],
   # [30, 34, 38],

   # Example 2 Input matrix:
   [
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
   ],
   # Expected Output:
   # [2, 1, 0],
   # [1, 2, 1],
   # [0, 1, 2],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   my $error = error($aref);
   $error ne 'ok' and say $error and say 'Moving on to next array.' and next;
   my @old_rows = @$aref;
   say 'Original matrix:';
   for my $old_row (@old_rows) {
      say '[', join(', ', @$old_row), ']';
   }
   my @new_rows = matrix_of_2x2_submatrix_sums($aref);
   say 'Matrix of 2x2 submatrix sums:';
   for my $new_row (@new_rows) {
      say '[', join(', ', @$new_row), ']';
   }
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
