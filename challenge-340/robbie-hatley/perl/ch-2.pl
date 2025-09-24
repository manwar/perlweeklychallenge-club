#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 340-2,
written by Robbie Hatley on Tue Sep 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 340-2: Ascending Numbers
Submitted by: Mohammad Sajid Anwar

You are given a string which is a list of tokens separated by
single spaces. Every token is either a positive number consisting
of digits 0-9 with no leading zeros, or a word consisting of
lowercase English letters. Write a script to check if all the
numbers in the given string are strictly increasing from left
to right.

Example #1:
Input:  "The cat has 3 kittens 7 toys 10 beds"
Output: true
Numbers 3, 7, 10 - strictly increasing.

Example #2:
Input:  'Alice bought 5 apples 2 oranges 9 bananas'
Output: false

Example #3:
Input:  'I ran 1 mile 2 days 3 weeks 4 months'
Output: true

Example #4:
Input:  'Bob has 10 cars 10 bikes'
Output: false

Example #5:
Input:  'Zero is 0 one is 1 two is 2'
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, for each token $t which consists solely of digits, I'll push (0+$t) to an array @a,
then return true if-and-only-if @a is strictly-increasing.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '("Jim ate 7 cats and 3 rats!", "Jim ate 3 cats and 7 rats!", "I ate 5 bats and 5 gnats.")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Are the numbers in a string strictly-increasing?
   sub strictly_increasing ($s) {
      my @t = split /\s+/, $s;
      my @n;
      for (@t) {
         push @n, 0+$_ if /^\d+$/}
      for (0..$#n-1) {
         return 'false' if $n[$_] >= $n[$_+1]}
      return 'true'}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "The cat has 3 kittens 7 toys 10 beds",
   # Expected output: true

   # Example 2 input:
   "Alice bought 5 apples 2 oranges 9 bananas",
   # Expected output: false

   # Example 3 input:
   "I ran 1 mile 2 days 3 weeks 4 months",
   # Expected output: true

   # Example 4 input:
   "Bob has 10 cars 10 bikes",
   # Expected output: false

   # Example 5 input:
   "Zero is 0 one is 1 two is 2",
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   my $i = strictly_increasing($s);
   say "String = \"$s\"";
   say "Numbers are strictly-increasing? $i"}
