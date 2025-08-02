#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 256-2.
Written by Robbie Hatley on Mon Feb 12, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 256-2: Merge Strings
Submitted by: Mohammad Sajid Anwar
You are given two strings, $str1 and $str2. Write a script to
merge the given strings by adding in alternative order
starting with the first string. If a string is longer than the
other then append the remaining at the end.

Example 1:
Input: $str1 = "abcd", $str2 = "1234"
Output: "a1b2c3d4"

Example 2:
Input: $str1 = "abc", $str2 = "12345"
Output: "a1b2c345"

Example 3:
Input: $str1 = "abcde", $str2 = "123"
Output: "a1b2c3de"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I could roll my own on this, but why? This problem is already solved by the "mesh" function from
CPAN module "List::Util", so I'll just use that. Doing otherwise would be like engineering and
manufacturing my own electric car at a cost of 5G$ when I could have bought a Tesla for 50k$.

One caveat with List::Util::mesh, though, is that it inserts undefs into its output if its two input strings
have unequal length. This can be got-around by using the "a//b" operator, which means "a if defined else b":

use v5.38;
use List::Util 'mesh';
sub merge_strings ($x, $y) {
   return join '', map {$_ // ''} mesh [split //, $x], [split //, $y];
}


--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like this:
./ch-2.pl '(["confabulated", "retroactive"],["AQGBT", "1379524"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBROUTINES:
use v5.38;
use List::Util 'mesh';
# Merge two strings:
sub merge_strings ($x, $y) {
   return join '', map {$_ // ''} mesh [split //, $x], [split //, $y];
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @pairs = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["abcd", "1234"],
   # Expected Output: "a1b2c3d4"

   # Example 2 Input:
   ["abc", "12345"],
   # Expected Output: "a1b2c345"

   # Example 3 Input:
   ["abcde", "123"],
   # Expected Output: "a1b2c3de"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN LOOP:
for my $pair_ref (@pairs) {
   say '';
   say 'Strings: ', join(', ', map {"\"$_\""} @$pair_ref);
   say 'Merged:  ', join(', ', map {"\"$_\""} merge_strings(@$pair_ref));
}
