#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 239-1.
Written by Robbie Hatley on Wed Oct 18, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Same String
Submitted by: Mohammad S Anwar
Given two arrays of strings, write a script to find out if the
word created by concatenating the array elements is the same.

Example 1:
Input: @arr1 = ("ab", "c")
       @arr2 = ("a", "bc")
Output: true
Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "a" . "bc" => "abc"

Example 2:
Input: @arr1 = ("ab", "c")
       @arr2 = ("ac", "b")
Output: false
Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "ac" . "b" => "acb"

Example 3:
Input: @arr1 = ("ab", "cd", "e")
       @arr2 = ("abcde")
Output: true
Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
Using @arr2, word2 => "abcde"


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of joining with "join" and comparing with "eq".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of two arrays of single-quoted strings, apostrophes escaped, in proper Perl
syntax, like so:
./ch-1.pl "([['ca', 'n\'t'], ['can', '\'t']], [['hot', 'dog'], ['red', 'fern']])"

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
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub same ($aref) {
   my $quot1 = join(', ', map {"\"$_\""} @{$$aref[0]});
   my $quot2 = join(', ', map {"\"$_\""} @{$$aref[1]});
   say 'Arrays = ([', $quot1, '], [', $quot2, '])';
   my $join1 = join('', @{$$aref[0]});
   my $join2 = join('', @{$$aref[1]});
   say 'Same string? ',
   $join1 eq $join2
   ? "Yes: \"$join1\" == \"$join2\""
   : "No:  \"$join1\" != \"$join2\"";
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [["ab", "c"], ["a", "bc"]],

   #Example 2 input:
   [["ab", "c"], ["ac", "b"]],

   #Example 3 input:
   [["ab", "cd", "e"], ["abcde"]],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   same($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
