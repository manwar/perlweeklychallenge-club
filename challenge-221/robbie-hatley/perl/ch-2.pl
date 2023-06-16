#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
File name:    "ch-2.pl"
Description:  Solutions in Perl for The Weekly Challenge 221-2.
Authorship:   Written by Robbie Hatley on Mon Jun 12, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Arithmetic Subsequence
Submitted by: Mohammad S Anwar
You are given an array of integers, @ints. Write a script to find the length of the longest Arithmetic
Subsequence in the given array. A subsequence is an array that can be derived from another array by deleting
some or none elements without changing the order of the remaining elements. A subsquence is arithmetic if
ints[i + 1] - ints[i] are all the same value (for 0 <= i < ints.length - 1).

Example 1:  Input: @ints = (9, 4, 7, 2, 10)  Output: 3
The longest Arithmetic Subsequence (4, 7, 10) can be derived by deleting 9 and 2.

Example 2:  Input: @ints = (3, 6, 9, 12)  Output: 4
No need to remove any elements, it is already an Arithmetic Subsequence.

Example 3:  Input: @ints = (20, 1, 15, 3, 10, 5, 8)  Output: 4
The longest Arithmetic Subsequence (20, 15, 10, 5) can be derived by deleting 1, 3 and 8.


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I think I'll solve this by using slices with indexes consisting of all combinations, of all lengths, of the
set of all indices [0..$#ints]. Math::Combinatorics will come to my aid once again. Start with the entire
array and keep decrementing the size until we get to a subsequence which is arithmetic. And ALL sequences
of integers always WILL contain an arithmetic subsquence, becuase all sequences of integers which are length
2, 1, or 0 are automatically arithmetic.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays in proper Perl syntax, like so:
./ch-2.pl '([13,0,27,-13], [7,5,2], [3,11], [42], [])'

Output is to STDOUT and will be each input array, followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use List::Util  'max';
use Math::Combinatorics;
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub is_arithmetic ($aref) {
   if (scalar(@$aref) < 3) {
      return 1;
   }
   my $period = $$aref[1]-$$aref[0];
   #say "period = $period";
   for ( my $i = 2 ; $i <= $#$aref ; ++$i ) {
      if ( $$aref[$i] - $$aref[$i-1] != $period ) {
         return 0;
      }
   }
   return 1;
}

sub longest_arithmetic_subsequence ($aref) {
   # How big of an array are we dealing with?
   my $size = scalar(@$aref);
   # If $size < 3, the longest arithmetic subsequence of @$aref is @$aref itself:
   if ( $size < 3 ) {
      return @$aref;
   }
   # Else the length of the longest arithmetic subsequence will be at-most $size and at-least 2:
   for ( my $n = $size ; $n >= 2 ; --$n ) {
      my $combs = Math::Combinatorics->new(count => $n, data => [0..$#$aref]);
      while (my @comb = $combs->next_combination) {
         my @indexes = sort {$a<=>$b} @comb;
         my @slice = @$aref[@indexes];
         #say "slice = (@slice)";
         if (is_arithmetic(\@slice)) {
            return @slice;
         }
      }
   }
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [9, 4, 7, 2, 10],
   [3, 6, 9, 12],
   [20, 1, 15, 3, 10, 5, 8],
);

# Non-default inputs:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# Main loop:
for my $aref (@arrays) {
   say '';
   my @longest = longest_arithmetic_subsequence($aref);
   my $length = scalar(@longest);
   say "sequence = (@$aref)";
   say "longest arithmetic subsequence: (@longest)";
   say "length = $length";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
