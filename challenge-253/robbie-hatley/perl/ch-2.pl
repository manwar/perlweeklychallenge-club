#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 253-2.
Written by Robbie Hatley on Mon Jan 22nd, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 253-2: Weakest Row
Submitted by: Mohammad S Anwar
You are given an m x n binary matrix i.e. only 0 and 1 where 1
always appear before 0. A row i is weaker than a row j if one
of the following is true:
a) The number of 1s in row i is less than
   the number of 1s in row j.
b) Both rows have the same number of 1 and i < j.
Write a script to return the order of rows from weakest to
strongest.

Example 1:
Input: $matrix = [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ]
Output: (2, 0, 3, 1, 4)
The number of 1s in each row is:
- Row 0: 2
- Row 1: 4
- Row 2: 1
- Row 3: 2
- Row 4: 5

Example 2:
Input: $matrix = [
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ]
Output: (0, 2, 3, 1)
The number of 1s in each row is:
- Row 0: 1
- Row 1: 4
- Row 2: 1
- Row 3: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
A combined sort can be indicated by PrimarySort || SecondarySort. In this case, the primary sort is by
"# of 1s" and secondary sort is by index. The "# of 1s" is just sum0(Row), and the indices are just
0..$#$aref. So this subroutine should do the trick:
sub weakest ($aref) {
   return sort {sum0(@{$$aref[$a]})<=>sum0(@{$$aref[$b]}) || $a<=>$b} 0..$#$aref;
}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of mxn matrices of 0s and 1s, 1s first, in proper Perl syntax, like so:
./ch-2.pl '([[1,1,1,0],[1,1,0,0]],[[1,0,0],[1,1,1],[1,1,0],[1,1,0]])'

Output is to STDOUT and will be each input followed by the corresponding output.

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
use List::Util 'sum0';

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Return the row indices of @$aref sorted from "weakest" to "strongest":
sub weakest ($aref) {
   return sort {sum0(@{$$aref[$a]})<=>sum0(@{$$aref[$b]}) || $a<=>$b} 0..$#$aref;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      [1, 1, 0, 0, 0],
      [1, 1, 1, 1, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 0, 0, 0],
      [1, 1, 1, 1, 1],
   ],
   # Expected Output: (2, 0, 3, 1, 4)

   # Example 2 Input:
   [
      [1, 0, 0, 0],
      [1, 1, 1, 1],
      [1, 0, 0, 0],
      [1, 0, 0, 0],
   ],
   # Expected Output: (0, 2, 3, 1)
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Matrix:';
   say join(', ', @$_) for @$aref;
   say 'Row indices sorted from weakest to strongest:';
   say '(', join(', ', weakest($aref)), ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
