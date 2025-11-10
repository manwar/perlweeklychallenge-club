#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 346-1,
written by Robbie Hatley on Tue Nov 04, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 346-1: Longest Parenthesis
Submitted by: Mohammad Sajid Anwar
You are given a string containing only ( and ). Write a script
to find the length of the longest valid parenthesis.

Example #1:
Input: $str = '(()())'
Output: 6
Valid Parenthesis: '(()())'

Example #2:
Input: $str = ')()())'
Output: 4
Valid Parenthesis: '()()' at positions 1-4.

Example #3:
Input: $str = '((()))()(((()'
Output: 8
Valid Parenthesis: '((()))()' at positions 0-7.

Example #4:
Input: $str = '))))((()('
Output: 2
Valid Parenthesis: '()' at positions 6-7.

Example #5:
Input: $str = '()(()'
Output: 2
Valid Parenthesis: '()' at positions 0-1 and 3-4.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll variable $fms to keep track of "first maximum-length parenthetically-valid
substring found so-far" and $fml to keep track of length of $fms. I'll then use a pair of nested ranged
for loops to test all possible substrings of size 2-or-more.

The outer loop will range $i from 0 to $l-2 (where $l is the length of the string). Before the inner loop,
set $p (parity) to 0, increment parity if character $i is '(', decrement parity if character $i is ')',
and skip to next $i if parity is now negative.

The inner loop will range $j from $i+1 to $l-1. Inside the inner loop, increment parity if character $j is
'(', decrement parity if character $j is ')', skip to next $i if parity is now negative, and if parity is
now 0, update $fms if we have found a new first maximum-length parenthetically-valid substring.

Then simply return ($fms, $fml).

The advantage to this approach is that it works even if non-parenthesis characters are present in the string,
as they will be in the case of arithmetic expressions such as "(1-(3*x-2*y))/17" (where the the max-length
valid substring is the entire string), or "))((5*a-7*b)/7)-42))" (where first max-length valid substring is
"((5*a-7*b)/7)-42").

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of strings, in proper Perl syntax, like so:

./ch-1.pl '("Mary ate a hat!", "))((5*a-7*b)/7)-42))", ")))))")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return first maximum-length parenthetically-valid
   # substring of a given string:
   sub first_max_par_substr ($s) {
      my $l   = length $s ; # Length of string.
      my $fms = ''        ; # First max-len par-val substr.
      my $fmi = 0         ; # Index  of $fsm.
      my $fml = 0         ; # Length of $fsm.
      my $i   = 0         ; # Idx of first char.
      my $j   = 0         ; # Idx of last  char.
      my $p   = 0         ; # Parity.
      my $c   = "\0"      ; # Current character.
      I: for $i (0..$l-2) {
         $c = substr $s, $i, 1;
         $p = 0;
         ++$p if '(' eq $c;
         --$p if ')' eq $c;
         next I if $p < 0;
         J: for $j ($i+1..$l-1) {
            $c = substr $s, $j, 1;
            ++$p if '(' eq $c;
            --$p if ')' eq $c;
            next I if $p < 0;
            if (0 == $p) {
               my $sl = $j-($i-1);
               if ($sl > $fml) {
                  $fms = substr $s, $i, $sl;
                  $fmi = $i;
                  $fml = $sl;
               }}}}
      ($fms, $fmi, $fml)}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   "(()())",
   # Expected output: "(()())", 0, 6

   # Example #2 input:
   ")()())",
   # Expected output: "()()", 1, 4

   # Example #3 input:
   "((()))()(((()",
   # Expected output: "((()))()", 0, 8

   # Example #4 input:
   "))))((()(",
   # Expected output: "()", 6, 2

   # Example #5 input:
   "()(()",
   # Expected output: "()", 0, 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "String = \"$s\"";
   my ($fms, $fmi, $fml) = first_max_par_substr($s);
   say "First max-length parenthetically-valid substring = \"$fms\"";
   say "at index $fmi with length $fml.";
}
