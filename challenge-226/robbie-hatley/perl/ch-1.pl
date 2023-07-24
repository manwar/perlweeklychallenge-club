#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 226-1.
Written by Robbie Hatley on Mon Jul 17, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Shuffle String
Submitted by: Mohammad S Anwar
You are given a string and an array of indices of same length as string.
Write a script to return the string after re-arranging the indices in the correct order.

Example 1:
Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
Output: 'challenge'

Example 2:
Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
Output: 'perlraku'

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem is the exact opposite of a Perl "slice", in that it asks not "What would this string look like
if rearranged in this order?", but rather, "What original string would look like THIS if rearranged in THIS
order?", which is a different question altogether. Fine, I'll start with a string of the same length but
consisting only of Unicode "invalid character" characters, "�". Then I'll over-write the given indices of
that string with the same-position characters of the given "scrambled" string.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays in proper Perl syntax. Each inner array must consist of a string followed by a
sequence of indices, which must be integers in the range 0..n-1 where n is the length of the string, like so:
./ch-1.pl "(['a si saftsic SeDsitna',12,11,10,9,8,16,15,14,20,19,18,17,13,2,1,0,7,6,5,4,3])"

Output is to STDOUT and will be each input array followed by corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub indices_are_valid ($string, @indices) {
   my $max_index = length($string)-1;
   for (@indices) {
      return 0 if $_ < 0 || $_ > $max_index;
   }
   return 1;
}

sub indices_are_bijective ($string, @indices) {
   return 0 if scalar(@indices) != length($string);
   my @sorted = sort {$a<=>$b} map {0+$_} @indices;
   for ( my $i = 0 ; $i <= $#sorted ; ++$i ) {
      return 0 if $sorted[$i] != $i;
   }
   return 1;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   ['lacelengh', 3,2,0,5,4,8,6,7,1],
   ['rulepark', 4,7,3,1,0,5,2,6],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   my @indices  = @$aref;
   my $shuffled = shift @indices;
   say "Shuffled: \"$shuffled\"";
   say "Indices:  (@indices)";
   my $length = length($shuffled);
   if ( ! indices_are_valid($shuffled,@indices) ) {
      say "Error: given indices are not valid for a string of length $length";
      say "(out-of-range values are present). Skipping to next string and indices.";
      next;
   }
   if ( ! indices_are_bijective($shuffled,@indices) ) {
      say "Error: given indices are not a remapping of a string of length $length";
      say "(gaps and/or overlaps are present). Skipping to next string and indices.";
      next;
   }
   my $original = '�' x length($shuffled);
   substr($original, $indices[$_], 1, substr($shuffled,$_,1)) for 0..$#indices;
   say "Original: \"$original\"";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
