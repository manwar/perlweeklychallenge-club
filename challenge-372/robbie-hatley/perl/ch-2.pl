#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 372-2,
written by Robbie Hatley on Dow Mon Dm, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 372-2: Largest Substring
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script to return the length of
the largest substring between two equal characters excluding the
two characters. Return -1 if there is no such substring.

(
   # Example #1 input:
   "aaaaa",
   # Expected output: 3

   # Example #2 input:
   "abcdeba",
   # Expected output: 5

   # Example #3 input:
   "abbc",
   # Expected output: 0

   # Example #4 input:
   "abcaacbc",
   # Expected output: 4

   # Example #5 input:
   "laptop",
   # Expected output: 2
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll make a pair of nested three-part loops, note all pairs of equal characters, and track longest length of
substrings between such pairs.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more arguments which must
be space-separated double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl "bob" "ratatouille" "anatomically"

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Find longest substring between equal characters:
   sub longest_between_equals ( $s ) {
      my $l = -1;
      my $n = length $s;
      for    ( my $i =    0   ; $i <= $n-2 ; ++$i ) {
         for ( my $j = $i + 1 ; $j <= $n-1 ; ++$j ) {
            if ( substr($s, $i, 1) eq substr($s, $j, 1) ) {
               if ( $j-1-$i > $l ) {
                  $l = $j-1-$i}}}}
      return $l}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   # Example #1 input:
   "aaaaa",
   # Expected output: 3

   # Example #2 input:
   "abcdeba",
   # Expected output: 5

   # Example #3 input:
   "abbc",
   # Expected output: 0

   # Example #4 input:
   "abcaacbc",
   # Expected output: 4

   # Example #5 input:
   "laptop",
   # Expected output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "Original string = \"$string\"";
   my $l = longest_between_equals($string);
   say "Longest substring between equal is $l characters long.";
}
