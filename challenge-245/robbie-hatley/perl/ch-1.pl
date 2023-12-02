#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 245-1.
Written by Robbie Hatley on Tue Nov 28, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 245-1: Sort Language
Submitted by: Mohammad S Anwar
You are given two arrays: one of languages and the other of their
popularities. Write a script to sort the languages based on their
popularities.

Example 1:
Input: @lang = ('perl', 'c', 'python'); @popularity = (2, 1, 3);
Output: ('c', 'perl', 'python')

Example 2:
Input: @lang = ('c++', 'haskell', 'java'); @popularity = (1, 3, 2);
Output: ('c++', 'java', 'haskell')

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I tried solving this problem by "zipping" the two arrays together to make an array of [language, popularity]
pairs, then sorting that array numerically by the second elements of the pairs; however, the resulting code
was excessively verbose. But then I hit upon a much easier way: use an array slice! Take the indexes of the
first array (0..$#$aref1), re-order them according to a sort of the second array, then "slice" the first
array using the re-ordered indexes. The result was that I could now solve this entire problem with half a line
of code.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of two arrays, with the inner array pairs consisting of an array of
single-quoted strings followed by an array of small positive integers (1-9), in proper Perl syntax, like so:
./ch-1.pl "([['Go','Lisp','AutoIt3','Logo'],[2, 19, 111, 3]],[['Awk','Cobol','Perl','Sed'],['golf','quaint','broad','easy']])"

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

sub is_array_of_numbers($aref) {
   return 0 if 'ARRAY' ne ref $aref;
   for (@$aref) {
      return 0 if !/^0$|^-?0\.\d+$|^-?[1-9]\d*(?:\.\d+)*$/;
   }
   return 1;
}

sub sort_array1_by_array2($aref1, $aref2) {
   is_array_of_numbers($aref2)
   and return @$aref1[sort{$$aref2[$a]<=>$$aref2[$b]}0..$#$aref1]
   or  return @$aref1[sort{$$aref2[$a]cmp$$aref2[$b]}0..$#$aref1]
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Inputs:
   [
      ['perl', 'c', 'python'],
      [2, 1, 3],
   ],
   # Expected Output: ('c', 'perl', 'python')

   # Example 2 Inputs:
   [
      ['c++', 'haskell', 'java'],
      [1, 3, 2],
   ],
   # Expected Output: ('c++', 'java', 'haskell')
);

# Main loop:
for my $aref (@arrays) {
   say '';
   my $aref1 = $aref->[0];
   my $aref2 = $aref->[1];
   say 'Languages    = (' . join(', ', map {"'$_'"} @$aref1) . ')';
   say 'Popularities = (' . join(', ',              @$aref2) . ')';
   if ( scalar(@$aref1) != scalar(@$aref2) ) {
      say 'Error: subarrays are of unequal lengths.';
      say 'Moving on to next array.';
      next;
   }
   my @sorted = sort_array1_by_array2($aref1, $aref2);
   say 'Sorted       = (' . join(', ', map {"'$_'"} @sorted) . ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
