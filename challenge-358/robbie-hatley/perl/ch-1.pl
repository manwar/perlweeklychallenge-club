#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 358-1,
written by Robbie Hatley on Fri Jan 30, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 358-1: Max Str Value
Submitted by: Mohammad Sajid Anwar
You are given an array of alphanumeric string, @strings. Write a
script to find the max "value" of alphanumeric string in the
given array which is the numeric representation of the string if
it consists of digits only, otherwise the length of the string.

Example #1:
Input: @strings = ("123", "45", "6")
Output: 123
"123" -> 123
"45"  -> 45
"6"   -> 6

Example #2:
Input: @strings = ("abc", "de", "fghi")
Output: 4
"abc"  -> 3
"de"   -> 2
"fghi" -> 4

Example #3:
Input: @strings = ("0012", "99", "a1b2c")
Output: 99
"0012"  -> 12
"99"    -> 99
"a1b2c" -> 5

Example #4:
Input: @strings = ("x", "10", "xyz", "007")
Output: 10
"x"   -> 1
"xyz" -> 3
"007" -> 7
"10"  -> 10

Example #5:
Input: @strings = ("hello123", "2026", "perl")
Output: 2026
"hello123" -> 8
"perl"     -> 4
"2026"     -> 2026

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This can be solved by simply calculating the "value" (as defined in the problem description) of each string
and keeping track of the maximum value seen so far.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '(["rat", "7", "armadillo"],["congratulations!", "15", "horse"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return maximum value of array of strings:
   sub max_val ( $aref ) {
      my $max = 0;
      for my $string (@$aref) {
         my $val=($string =~ m/^\d+$/)?
         0+$string:length($string);
         $val > $max and $max = $val;
      }
      $max;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   ["123", "45", "6"],
   # Expected output: 123

   # Example #2 inputs:
   ["abc", "de", "fghi"],
   # Expected output: 4

   # Example #3 inputs:
   ["0012", "99", "a1b2c"],
   # Expected output: 99

   # Example #4 inputs:
   ["x", "10", "xyz", "007"],
   # Expected output: 10

   # Example #5 inputs:
   ["hello123", "2026", "perl"],
   # Expected output: 2026
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Strings = (@$aref)";
   my $max = max_val($aref);
   say "Max val = $max";
}
