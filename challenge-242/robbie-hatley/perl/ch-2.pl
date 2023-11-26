#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 242-2.
Written by Robbie Hatley on Mon Nov 06, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Flip Matrix
Submitted by: Mohammad S Anwar
Given n x n binary matrix, write a script to flip
the given matrix as below:
1 1 0
0 1 1
0 0 1
a) Reverse each row
0 1 1
1 1 0
1 0 0
b) Invert each member
1 0 0
0 0 1
0 1 1

Example 1:
Input:  ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2:
Input:  ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Reversing the rows is easily done with "reverse", and logically-inverting the elements can be done with "!".
However, instead of doing that, I think I'll use a combined approach using ranged "for", "!", and "unshift":

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of elements, each of which are 0 or 1, in proper Perl syntax, like so:
./ch-2.pl '([[1,1,1],[0,0,0],[1,1,1]],[[1,0,0],[0,1,0],[0,0,1]])'

Output is to STDOUT and will be each input array followed by the corresponding output.

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

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0;
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a referred-to array a matrix (array of arrays) of
# bools (elements which are "0" or "1")?
sub is_matrix_of_bools ($matref) {
   return 0 if 'ARRAY' ne ref $matref;
   for my $rowref (@$matref) {
      return 0 if 'ARRAY' ne ref $rowref;
      for my $element ( @{$rowref} ) {
         return 0 if '0' ne $element && '1' ne $element;
      }
   }
   return 1;
}

# Flip-and-negate a matrix of bools:
sub flip_mat ($matref) {
   my @flipped;
   for my $rowref (@{$matref}) {
      my @new_row = ();
      unshift(@new_row, (!$_ ? '1' : '0')) for @{$rowref};
      push @flipped, [@new_row];
   }
   return @flipped;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example1 input:
     [[1, 1, 0], [1, 0, 1], [0, 0, 0]],
   # Expected output:
   # ([1, 0, 0], [0, 1, 0], [1, 1, 1])

   # Example2 input:
     [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]],
   # Expected output:
   # ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
);

# Main loop:
for my $matref (@matrices) {
   say '';
   say 'Matrix = ';
   say join(', ', @{$_}) for @{$matref};
   if (!is_matrix_of_bools($matref)) {
      say 'Error: Not a matrix of bools. Skipping to next matrix.';
      next;
   }
   my @flipped = flip_mat($matref);
   say 'Flipped = ';
   say join(', ', @{$_}) for @flipped;
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
