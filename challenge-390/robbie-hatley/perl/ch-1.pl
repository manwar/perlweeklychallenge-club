#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 390-1,
written by Robbie Hatley on Sun Sep 13, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 390-1: Decode String
Submitted by: Mohammad Sajid Anwar
You are given an encoded string. Write a script to return the
decoded string of the given encoded string. The encoding rule
is: K[encoded_string], where the encoded_string inside the
square brackets is repeated exactly K > 0 times.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll use a Perl s/// operator in a while loop to decode innermost bracket pairs for as long as some exist,
thus solving the problem from the inside out.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Example (two valid inputs):

./ch-1.pl '3[2[rat]4[pig]]' '2[5[MW]a]'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Decode an encoded string:
   sub decode ( $s ) {
      while ($s =~ s/([1-9][0-9]*)\[([^\[\]]*)\]/$2x$1/e) {
         ; # Do nothing.
      }
      $s;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   # Example 1 input:
   "2[3[a]]",
   # Expected output: "aaaaaa"

   # Example 2 input:
   "10[a]",
   # Expected output: "aaaaaaaaaa"

   # Example 3 input:
   "a2[b]c3[d]e",
   # Expected output: "abbcddde"

   # Example 4 input:
   "2[a2[b]c]",
   # Expected output: "abbcabbc"

   # Example 5 input:
   "1[a]2[b3[c]]",
   # Expected output: "abcccbccc"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

for my $string (@strings) {
   say '';
   say "Encoded string = $string";
   my $dstrng = decode($string);
   say "Decoded string = $dstrng";
}
