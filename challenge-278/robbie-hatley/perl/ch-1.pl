#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 278-1,
written by Robbie Hatley on Mon Jul 15, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 278-1: Sort String
Submitted by: Mohammad Sajid Anwar
Given a shuffled string, write a script to return the sorted
string. A string is shuffled by appending word position to
each word.

Example 1 input:
"and2 Raku3 cousins5 Perl1 are4"
Expected output: "Perl and Raku are cousins"

Example 2 input:
"guest6 Python1 most4 the3 popular5 is2 language7"
Expected output: "Python is the most popular guest language"

Example 3 input:
"Challenge3 The1 Weekly2"
Expected output: "The Weekly Challenge"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
My first idea was to do this:
1. Split the string by whitespace to array of tokens "@tokens".
2. Sort "@tokens" to array "@sorted" by numerical order of the "ordinal" part of each token.
3. Join with spaces a map of the "word" part of each token.

But then I realized, I don't need any of the intermediates, and this is best written in reverse order,
as a "functional-programming" subroutine:
   use v5.38;
   use utf8;
   sub word    ($token) {$token =~ s/\d+$//r}
   sub ordinal ($token) {$token =~ s/^\D+//r}
   sub sort_string ($string) {
      join ' ',
      map {word($_)}
      sort {(0+ordinal($a)) <=> (0+ordinal($b))}
      split /\s+/, $string
   }


--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings of space-separated tokens, with the last character of each token
being a numerical "position" indicator, in proper Perl syntax, like so:
./ch-1.pl '("she10 her3 and5 chicken12 while9 petted6 she1 legs4 her7 ate11 shaved2 dog8",)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   sub word    ($token) {$token =~ s/\d+$//r}
   sub ordinal ($token) {$token =~ s/^\D+//r}
   sub sort_string ($string) {
      join ' ',
      map {word($_)}
      sort {(0+ordinal($a)) <=> (0+ordinal($b))}
      split /\s+/, $string
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "and2 Raku3 cousins5 Perl1 are4",
   # Expected output: "Perl and Raku are cousins"

   # Example 2 input:
   "guest6 Python1 most4 the3 popular5 is2 language7",
   # Expected output: "Python is the most popular guest language"

   # Example 3 input:
   "Challenge3 The1 Weekly2",
   # Expected output: "The Weekly Challenge"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say 'Shuffled string = ', $string;
   say 'Sorted   string = ', sort_string $string;
}
