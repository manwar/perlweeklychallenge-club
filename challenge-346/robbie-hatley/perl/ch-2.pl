#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 346-2,
written by Robbie Hatley on Tue Nov 04, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 346-2: Magic Expression
Submitted by: Mohammad Sajid Anwar
You are given a string containing only digits and a target
integer. Write a script to insert binary operators +, - and *
between the digits in the given string that evaluates to target
integer.

Example #1:
Input: $str = "123", $target = 6
Output: ("1*2*3", "1+2+3")

Example #2:
Input: $str = "105", $target = 5
Output: ("1*0+5", "10-5")

Example #3:
Input: $str = "232", $target = 8
Output: ("2*3+2", "2+3*2")

Example #4:
Input: $str = "1234", $target = 10
Output: ("1*2*3+4", "1+2+3+4")

Example #5:
Input: $str = "1001", $target = 2
Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll approach this problem as follows:
1. First make a list of all partitions of the string.
2. For each partition which contains only valid non-negative integers, insert all possible combinations of
   operators, and accumulate those combinations which yield the target value.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["rat", "bat", "cat"],["pig", "cow", "horse"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return a list of all partitions of a string:
   sub parts ($str) {
      my $len = length($str);
      my @parts;
      for my $cutmask (0 .. 2**($len - 1) - 1) {
         my @partition;
         my $chunk = substr($str, 0, 1);
         for my $i (1 .. $len - 1) {
            if ( $cutmask & (1 << ($len - 1 - $i)) ) {
               push @partition, $chunk;
               $chunk = ''}
            $chunk .= substr($str, $i, 1)}
         push @partition, $chunk;
         push @parts, \@partition}
      @parts}

   # Return those combinations of partitions and operations
   # which yield desired target
   sub accumulate_targets ( $s, $t ) {
      my @e = ();
      my @parts = parts($s);
      @e;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["123",   6],
   ["105",   5],
   ["232",   8],
   ["1234", 10],
   ["1001",  2],
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
foreach my $aref (@arrays) {
   say '';
   my $s = $aref->[0];
   my $t = $aref->[1];
   say "String = \"$s\"; target = \"$t\".";
   my @partitions = parts $s;
   foreach my $partition (@partitions) {
      my @chunks = @$partition;
      say "Chunks: (@chunks)";
   }
   say "This program is not fully implemented yet.";
}
