#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 273-1,
written by Robbie Hatley on Mon Jun 10, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 273-1: Percentage of Character
Submitted by: Mohammad Sajid Anwar
You are given a string, $str and a character $chr. Write a
script to return the nearest integer percentage of the
characters in $str which are $chr.

Example 1:
Input: $str = "perl", $chr = "e"
Output: 25

Example 2:
Input: $str = "java", $chr = "a"
Output: 50

Example 3:
Input: $str = "python", $chr = "m"
Output: 0

Example 4:
Input: $str = "ada", $chr = "a"
Output: 67

Example 5:
Input: $str = "ballerina", $chr = "l"
Output: 22

Example 6:
Input: $str = "analitik", $chr = "k"
Output: 13

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of counting instances of $chr in $str, dividing by length($str), multiplying by 100,
and rounding to nearest integer. The m// operator and the "lround" function from POSIX are useful here:

   sub pct_chr_in_str ($str, $chr) {
      my $length = length($str);
      my @matches = $str =~ m/$chr/g;
      lround(100*(scalar(@matches)/$length));
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax. The second element of each
inner array will be construed as a character to be searched-for in the first element. Eg:
./ch-1.pl '(["aardvark", "a"], ["茶と茶と茶", "茶"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   use POSIX 'lround';

   # What is the percentage, to the nearest integer,
   # of a given character in a given string?
   sub pct_chr_in_str ($str, $chr) {
      lround(100*(scalar(@{[$str =~ m/$chr/g]})/length($str)));
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   ["perl", "e"],
   # Expected output: 25

   # Example 2:
   ["java", "a"],
   # Expected output: 50

   # Example 3:
   ["python", "m"],
   # Expected output: 0

   # Example 4:
   ["ada", "a"],
   # Expected output: 67

   # Example 5:
   ["ballerina", "l"],
   # Expected output: 22

   # Example 6:
   ["analitik", "k"],
   # Expected output: 13
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
say 'Percentange (to nearest integer) of each character in each string:';
for my $aref (@arrays) {
   say '';
   my ($str, $chr) = @$aref;
   my $pcis = pct_chr_in_str($str, $chr);
   say "String = $str";
   say "Char   = $chr";
   say "Pct    = $pcis%";
}
