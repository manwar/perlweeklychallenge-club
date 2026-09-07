#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 387-1,
written by Robbie Hatley on Tue Aug 18, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 387-1: Rearrange Binary String
Submitted by: Mohammad Sajid Anwar
You are given a binary string. Write a script to re-arrange
the string that all occurrences of “01” are simultaneously
replaced with “10” until no occurrences of “01” exist.
Return the total steps needed.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use a s///g operator in a while loop and count how many times it runs.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
arguments which must be single-quoted strings of 1s and or 0s, like so:

./ch-1.pl '01011010' '11010100'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # How many simultaneous substitutions of '10'
   # for all existing '01' can be performed?
   sub num_subs ( $x ) {
      my $n = 0;
      ++$n while $x =~ s/01/10/g;
      return $n;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   '111000', # 0
   '00011',  # 4
   '01011',  # 3
   '010101', # 3
   '00001',  # 4
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say "String = $string";
   my $ns = num_subs($string);
   say "01→10  = $ns";
}
