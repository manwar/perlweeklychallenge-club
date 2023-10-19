#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 239-2.
Written by Robbie Hatley on Wed Oct 18, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 2: Consistent Strings
Submitted by: Mohammad S Anwar
Given an array of strings and a "string of allowed characters"
(consisting of distinct characters), write a script to determine
how many strings in the array are "consistent" in the sense that
they consist only of characters which appear in the "string of
allowed characters".

Example 1:
Input: @str = ("ad", "bd", "aaab", "baa", "badab")
       $allowed = "ab"
Output: 2
Strings "aaab" and "baa" are consistent since they only contain
characters 'a' and 'b'.

Example 2:
Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
       $allowed = "abc"
Output: 7

Example 3:
Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
       $allowed = "cad"
Output: 4
Strings "cc", "acd", "ac", and "d" are consistent.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I could do this by breaking the strings to arrays, but that seems awkward. Or, I could use "substr", but that
seems even MORE awkward. I think I'll use regular expressions instead. Maybe not as fast, but more elegant.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of single-quoted strings, apostrophes escaped, with the last element of each
inner array being construed as a "string of allowed characters", in proper Perl syntax, like so:
./ch-2.pl "(['I\'ll go away.', 'She ran home.', 'ISaeghlmnorwy.\' '], ['green', 'golf', 'abc'])"

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

sub consistent ($aref) {
   my @array = @$aref;
   my $allowed = pop @array;
   say 'Array = (' . join(', ', map {"\"$_\""} @array) . ')';
   say "Allowed characters = \"$allowed\"";
   my @consistent = ();
   # Push strings consisting only of "allowed" characters to @consistent:
   /^[$allowed]+$/ and push @consistent, $_ for @array;
   my $n = scalar(@consistent);
   say "$n of the strings in the array are consistent with the allowed characters.";
   say 'Consistent = (' . join(', ', map {"\"$_\""} @consistent) . ')' if $n;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   ["ad", "bd", "aaab", "baa", "badab", "ab"],

   # Example 2 input:
   ["a", "b", "c", "ab", "ac", "bc", "abc", "abc"],

   # Example 3 input:
   ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d", "cad"],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   consistent($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
