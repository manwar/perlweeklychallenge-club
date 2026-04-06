#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 367-1,
written by Robbie Hatley on Tue Mar 31, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 367-1: Max Odd Binary
Submitted by: Mohammad Sajid Anwar
You are given a binary string that has at least one ‘1’. Write a
script to rearrange the bits in such a way that the resulting
binary number is the maximum odd binary number and return the
resulting binary string. The resulting string can have leading
zeros.

Example 1
Input: $str = "1011"
Output: "1101"

Example 2
Input: $str = "100"
Output: "001"

Example 3
Input: $str = "111000"
Output: "110001"

Example 4
Input: $str = "0101"
Output: "1001"

Example 5
Input: $str = "1111"
Output: "1111"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
A positive integer is "odd" if-and-only-if its least-significant binary digit is "1", and it is "maximum" if
all of the 1s are clustered on the left end. So the "x" operator will work for this. Given $m 0s and $n 1s,
max is '1'x($n-1) . '0'x$m . '1'.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted binary numbers, in proper Perl syntax, like so:

./ch-1.pl '("10101010", "00111100", "00001111")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Make the maximum possible odd binary number by
   # re-ordering the binary digits of a positve integer:
   sub max_odd_binary ( $x ) {
      my $m = scalar (my @z = ($x =~ m/0/g));
      my $n = scalar (my @o = ($x =~ m/1/g));
      '1'x($n-1) . '0'x$m . '1';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   "1011",   # "1101"
   "100",    # "001"
   "111000", # "110001"
   "0101",   # "1001"
   "1111",   # "1111"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "Input binary number string = \"$s\"";
   my $max = max_odd_binary($s);
   say "Maximum odd binary  string = \"$max\"";
}
