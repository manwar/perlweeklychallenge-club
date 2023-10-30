#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 234-1.
Written by Robbie Hatley on Mon Sep 11, 2023.
Did   further   editing  on Tue Sep 12, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Common Characters
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetic characters only. Write a script
to return all alphabetic characters that show up in all words, including duplicates.

Example 1:
Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")

Example 2
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 3
Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I think I'll solve this by making these subroutines:

sub is_alpha ($aref); # Return boolean indicating whether-or-not an array contains only alphabetical strings.
sub unique_letters ($aref); # Return list of unique letters in the strings of array.
sub copies ($letter, $string); # Return number of copies of $letter which exist in string.
sub min_copies ($letter, $aref); # Return minium of numbers of copies of letter in strings of array.
Then follow this algorithm for each array:
1. Make sure array is alphabetic.
2. Make an array "@letters" of the unique letters from the array.
3. Make an array "@output" to hold output.
3. For each $letter of @letters, push $letter x minimum_copies($letter, $aref) onto @output.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of single-quoted /^[a-zA-Z]+$/ strings, in proper Perl syntax, like so:
./ch-1.pl "(['Robbie', 'Mike', 'Steve'],['dog', 'cat', 'pig'],['maw', 'raw', 'saw'])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

# Pragmas:
use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';

# CPAN modules:
use Sys::Binmode;
use Time::HiRes 'time';
use List::Util  'uniq';

# ------------------------------------------------------------------------------------------------------------
# VARIABLES:

# Debug?
my $Db = 0;

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Return boolean indicating whether-or-not an array contains only alphabetical strings:
sub is_alpha ($aref) {
   for my $string (@$aref) {
      return 0 if $string !~ m/^[[:alpha:]]+$/;
   }
   return 1;
}

# Return list of unique letters appearing in the strings of @$aref:
sub unique_letters ($aref) {
   my @letters = ();
   for my $string ( @$aref ) {
      push @letters, split('', $string);
   }
   return uniq sort @letters;
}

# Return number of copies of $letter which exist in $string:
sub copies ($letter, $string) {
   say "In copies() at top; \$letter = $letter and \$string = $string" if $Db;
   my $count = 0;
   map {++$count if $_ eq $letter} split('', $string);
   return $count;
}

# Return minium of numbers of copies of letter in strings of @$aref:
sub min_copies ($letter, $aref) {
   my $min_cop = copies($letter, $$aref[0]);
   map {
      say "In min_copies() map; \$_ = $_" if $Db;
      my $cop = copies($letter, $_);
      $min_cop = $cop if $cop < $min_cop;
   } @$aref;
   return $min_cop;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   ["java", "javascript", "julia"],
   ["bella", "label", "roller"],
   ["cool", "lock", "cook"],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   !is_alpha($aref) and say "Error: Array not alphabetic."
                    and say "Skipping to next array."
                    and next;
   my @letters = unique_letters($aref);
   if ( $Db ) {
      say "In main loop. \@letters = ";
      say for @letters;
   }
   my @output = ();
   for my $letter ( @letters ) {
      my $mc = min_copies($letter, $aref);
      if ( $mc > 0 ) {
         for ( 1..$mc ) {
            push @output, $letter;
         }
      }
   }
   say 'Original array = (', join(', ', map {"\"$_\""} @$aref ), ')';
   say 'Common letters = (', join(', ', map {"\"$_\""} @output), ')';
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
