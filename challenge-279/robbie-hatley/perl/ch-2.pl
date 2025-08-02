#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 279-2,
written by Robbie Hatley on Mon Jul 22, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 279-2: Split String
Submitted by: Mohammad Sajid Anwar
Given a string $str, write a script to split $str into two
strings, each containing exactly same number of vowels.
Return true if you can, otherwise return false.

Example 1:
Input: $str = "perl"
Ouput: false

Example 2:
Input: $str = "book"
Ouput: true

Example 3
Input: $str = "good morning"
Ouput: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I don't even bother actually splitting strings, since we're only interested in whether the number of vowels
is even. So I make two subs, "count_vowels" and "can_split", which do as their names suggest. The only
tricky part is defining what a "vowel" is. For the purposes of this exercise I'll define a "vowel" to be
any of [aeiouAEIOU] with-or-without combining marks.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings in proper Perl syntax, like so:
./ch-2.pl '("Is Trump a winner?", "Will Kamala be President?")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use Unicode::Normalize 'NFD';
   sub count_vowels ($string) {scalar map {$_} NFD($string) =~ m/[aeiouAEIOU]/g}
   sub can_split ($string) {(0==count_vowels($string)%2)?"true":"false"}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "perl",
   # Expected ouput: false

   # Example 2:
   "book",
   # Expected ouput: true

   # Example 3
   "good morning",
   # Expected ouput: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   my $result = can_split($string);
   say '';
   say "String = $string";
   say "Result = $result";
}
