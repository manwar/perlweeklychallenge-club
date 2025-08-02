#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 253-1.
Written by Robbie Hatley on Mon Jan 22, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 253-1: Split Strings
Submitted by: Mohammad S Anwar
You are given an array of strings and a character separator.
Write a script to return all words separated by the given
character excluding empty string.

Example 1:
Input: @words = ("one.two.three","four.five","six")
       $separator = "."
Output: "one","two","three","four","five","six"

Example 2:
Input: @words = ("$perl$$", "$$raku$")
       $separator = "$"
Output: "perl","raku"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of splitting strings based on the given separator, then dumping the empty strings.
One complicating factor, though, is that for separators such as the "." and "$" given in the examples to
actually work, they must be stripped of their magical "meta" powers by using the "\Q" de-meta operator.
So something like this sub should work:
sub split_strings ($separator, @array) {
   return grep {length($_)>0} map {split /\Q$separator\E/, $_} @array;
}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, apostrophes escaped as '"'"', with the last element
of each inner array being construed as a "separator", in proper Perl syntax, like so:
./ch-1.pl '(["He shaved?", "She ate dogs.", " "],["didn'"'"'t bathe", "hadn'"'"'t eaten", "'"'"'"])'

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

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Split the strings of an array, using a de-meta-ed separator:
sub split_strings ($separator, @array) {
   return grep {length($_)>0} map {split /\Q$separator\E/, $_} @array;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["one.two.three", "four.five", "six", "."],
   # Expected Output: "one","two","three","four","five","six"

   # Example 2 Input:
   ["\$perl\$\$", "\$\$raku\$", "\$"],
   # Expected Output: "perl","raku"
);

# Main loop:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $separator = splice @array, -1, 1;
   say 'Input  array = (', join(', ', map {"\"$_\""} @array), ')';
   say 'Separator    = ', '"', $separator, '"';
   say 'Output array = (', join(', ', map {"\"$_\""} split_strings($separator, @array)), ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
