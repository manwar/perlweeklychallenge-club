#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 331-1,
written by Robbie Hatley on Mon Jul 21, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 331-1: Last Word
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script to find the length of last
word in the given string.

Example #1:
Input: $str = "The Weekly Challenge"
Output: 9

Example #2:
Input: $str = "   Hello   World    "
Output: 5

Example #3:
Input: $str = "Let's begin the fun"
Output: 3

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
There are a number of ways of approaching this, including using "split" to obtain a list of words which are in
the string. But I'll use a simpler approach: I'll use an m// operator with a (capture group) to isolate the
final word into "$1", then feed "$1" into the length() operator.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("I ate a rat", "she ate a leprechaun", "   lots   of   spaces   ")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   # What is the length of the last
   # word of a given sentence?
   sub length_of_last_word ($s)
   {$s =~ m/(\S+)\s*$/;length $1}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("The Weekly Challenge", "   Hello   World    ", "Let's begin the fun");
#                  Expected outputs :             9                       5                        3

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "String = \"$string\"";
   my $lolw = length_of_last_word($string);
   say "Length of last word = $lolw";
}
