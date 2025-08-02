#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 278-2,
written by Robbie Hatley on Mon Jul 15, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 278-2: Reverse Word
Submitted by: Mohammad Sajid Anwar
Given a word, $word and a character, $char, write a script to
replace the substring up to and including $char with its
characters sorted alphabetically. If $char doesn’t exist in
$word then don't do anything.

Example 1 input:
["challenge", "e"],
Expected output: "acehllnge"

Example 2 input:
["programming", "a"],
Expected output: "agoprrmming"

Example 3 input:
["champion", "b"],
Expected output: "champion"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll solve this by using a programmatic substitution:

   use v5.38;
   use utf8;
   sub sort_string ($string, $char) {
      $string =~ s{^(.*?$char)}{join '', sort split //, $1}er;
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted (array of [word, character] pairs), in proper Perl syntax, like so:
./ch-2.pl '(["enslaved","a"], ["amalgamated","t"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   sub sort_string ($string, $char) {
      $string =~ s{^(.*?$char)}{join '', sort split //, $1}er;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   ["challenge", "e"],
   # Expected output: "acehllnge"

   # Example 2 input:
   ["programming", "a"],
   # Expected output: "agoprrmming"

   # Example 3 input:
   ["champion", "b"],
   # Expected output: "champion"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my $string = $aref->[0];
   my $char   = $aref->[1];
   my $sorted = sort_string($string,$char);
   say 'Original string = ', $string;
   say 'Sorted   string = ', $sorted;
}
