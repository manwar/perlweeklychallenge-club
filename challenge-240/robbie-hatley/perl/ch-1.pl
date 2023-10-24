#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 240-1.
Written by Robbie Hatley on Tue Oct 24, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Acronym
Submitted by: Mohammad S Anwar
You are given an array of strings and a check string. Write a
script to find out if the check string is the acronym of the
words in the given array.

Example 1:
Input: @str = ("Perl", "Python", "Pascal"); $chk = "ppp";
Output: true

Example 2:
Input: @str = ("Perl", "Raku"); $chk = "rp";
Output: false

Example 3:
Input: @str = ("Oracle", "Awk", "C"); $chk = "oac";
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of making these two subs:
1. "sub acronym (@list) {return join('', map {substr $_, 0, 1} @list);}
2. "sub ncscomp ($x,$y) {return (fc($x) eq fc($y));}"
Note: Though the official problem statement doesn't say so, the examples make it clear that either the check
is compared to the lc or fc of the acronym, or the comparison is non-case sensitive. I elect NCS comparison.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of single-quoted strings, apostrophes escaped, in proper Perl syntax;
the last string of each inner array will serve as the "acronym check string" for the array:
./ch-1.pl "(['Robbie', 'can\'t', 'sing', 'rCs'],['PERL', 'raku', 'C++', 'pRc']),['acre','zebra','za']"

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

# Format an array of strings as ("string1", "string2", "string3"):
sub arrayst (@arry) {return '('.join(', ', map {"\"$_\""} @arry).')'}

# Return the acronym of a list of strings:
sub acronym (@list) {return join '', map {substr $_, 0, 1} @list}

# Non-Case-Sensitively compare two strings:
sub ncscomp ($x,$y) {return fc $x eq fc $y}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   ['Perl', 'Python', 'Pascal', 'ppp'],
   # Expected output: true

   # Example 2 input:
   ['Perl', 'Raku', 'rp'],
   # Expected output: false

   # Example 3 input:
   ['Oracle', 'Awk', 'C', 'oac'],
   # Expected output: true
);

# Main loop:
for my $aref (@arrays) {
   my @str = @$aref;
   my $chk = pop @str;
   say '';
   say "Array = ", arrayst(@str);
   say "Check = ", $chk;
   say "Acronym equals check? ",ncscomp(acronym(@str),$chk)?'Yes.':'No.';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
