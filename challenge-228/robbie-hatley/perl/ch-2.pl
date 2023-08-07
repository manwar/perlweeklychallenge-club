#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 228-2.
Written by Robbie Hatley on Wed Aug 02, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Empty Array
Submitted by: Mohammad S Anwar

You are given an array of integers in which all elements are unique. Write a script to perform the following
operations until the array is empty, and return the total count of operations: If the first element is the
smallest then remove it otherwise move it to the end.

Example 1:  Input: @int = (3, 4, 2)  Output: 5
Operation 1: move 3 to the end: (4, 2, 3)
Operation 2: move 4 to the end: (2, 3, 4)
Operation 3: remove element 2: (3, 4)
Operation 4: remove element 3: (4)
Operation 5: remove element 4: ()

Example 2:  Input: @int = (1, 2, 3)  Output: 3
Operation 1: remove element 1: (2, 3)
Operation 2: remove element 2: (3)
Operation 3: remove element 3: ()

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I use List::Util::min, shift, and push, and increment a counter:

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of uniq integers, in proper Perl syntax, like so:
./ch-2.pl "([9,2,'dog',7],[3,7,3,7],[1,6,2,7,3,8,4,9],[8,7,6,5,4,3,2,1])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;

use Sys::Binmode;
use Time::HiRes 'time';
use List::Util 'min';

$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub num_moves ($aref) {
   my @array = @$aref;                         # Grab copy of original array.
   my $moves = 0;                              # Count moves.
   while (@array) {                            # For each element,
      $array[0] == min @array and shift @array # if first is min, discard first;
      or push @array, shift @array;            # otherwise, move first to last.
      ++$moves;                                # Increment moves.
   }
   return $moves;                              # Return total moves.
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [3, 4, 2],
   [1, 2, 3],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say "\nArray = (@$aref)";
   say "Number of moves = ", num_moves $aref;
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
