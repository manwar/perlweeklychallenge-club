#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 352-2,
written by Robbie Hatley on Mon Dec 15, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 352-2: Binary Prefix
Submitted by: Mohammad Sajid Anwar
You are given an array, @nums, where each element is 0 or 1.
Define x[i] as the number formed by taking the first i+1 bits of
@nums (from $nums[0] through $nums[i]) and interpreting them as
a binary number, with $nums[0] being the most significant bit.
For example, if @nums = (1, 0, 1), then:
x0 = 1 (binary 1)
x1 = 2 (binary 10)
x2 = 5 (binary 101)
Write a script to return an array @answer where $answer[i] is
true if x[i] is divisible by 5, otherwise false.

Example #1:
Input: @nums = (0,1,1,0,0,1,0,1,1,1)
Output: (true, false, false, false, false, true, true, false, false, false)
Binary numbers formed (decimal values):
0: 0
01: 1
011: 3
0110: 6
01100: 12
011001: 25
0110010: 50
01100101: 101
011001011: 203
0110010111: 407

Example #2:
Input: @num = (1,0,1,0,1,0)
Output: (false, false, true, true, false, false)
1: 1
10: 2
101: 5
1010: 10
10101: 21
101010: 42

Example #3:
Input: @num = (0,0,1,0,1)
Output: (true, true, false, false, true)
0: 0
00: 0
001: 1
0010: 2
00101: 5

Example #4:
Input: @num = (1,1,1,1,1)
Output: (false, false, false, true, false)
1: 1
11: 3
111: 7
1111: 15
11111: 31

Example #5:
Input: @num = (1,0,1,1,0,1,0,0,1,1)
Output: (false, false, true, false, false, true, true, true, false, false)
1: 1
10: 2
101: 5
1011: 11
10110: 22
101101: 45
1011010: 90
10110100: 180
101101001: 361
1011010011: 723

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use "join '', @num[0..$i]" to make each "binary prefix", tack a "0b" to its left,
use "oct" to convert it to an integer $int, and use "if (0==$int%5) {...}" to check for divisibility by 5.
Or combine all those steps in one line:
if (0==oct('0b'.join '', @num[0..$i])%5) {push @out, 'true'} else {push @out, 'false'}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 0s and 1s, in proper Perl syntax, like so:

./ch-2.pl '([1,0,1,1,0,0,1,0], [1,1,1,1,1,1,1,1], [1,0,1,0,1,0,1,0])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Which binary prefixes are divisible by 5?
   sub bp ( $aref ) {
      my @out;
      for my $i (0..$#$aref) {
         if (0==oct('0b'.join '', @$aref[0..$i])%5) {
            push @out, 'true'}
         else {
            push @out, 'false'}}
      @out}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [0,1,1,0,0,1,0,1,1,1],
   # Expected output: (true, false, false, false, false, true, true, false, false, false)

   # Example #2 input:
   [1,0,1,0,1,0],
   # Expected output: (false, false, true, true, false, false)

   # Example #3 input:
   [0,0,1,0,1],
   # Expected output: (true, true, false, false, true)

   # Example #4 input:
   [1,1,1,1,1],
   # Expected output: (false, false, false, true, false)

   # Example #5 input:
   [1,0,1,1,0,1,0,0,1,1],
   # Expected output: (false, false, true, false, false, true, true, true, false, false)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say " Input = (@$aref)";
   my @bp = bp($aref);
   say "Output = (@bp)";
}
