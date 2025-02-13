#!/usr/bin/env -S perl -C63

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 308-1,
written by Robbie Hatley on Mon Feb 10, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 308-1: Count Common
Submitted by: Mohammad Sajid Anwar
You are given two array of strings, @str1 and @str2. Write a
script to return the count of common strings in both arrays.

Example #1:
Input: @str1 = ("perl", "weekly", "challenge")
       @str2 = ("raku", "weekly", "challenge")
Output: 2

Example #2:
Input: @str1 = ("perl", "raku", "python")
       @str2 = ("python", "java")
Output: 1

Example #3:
Input: @str1 = ("guest", "contribution")
       @str2 = ("fun", "weekly", "challenge")
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
For each set of strings I'll make a hash counting occurrences. Then I'll make a (sorted, deduped) "combined"
string set from the two originals. Then I'll push any element of @combined which has greater-than-zero
occurrences in both original string sets to an array "@common" and return that.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of double-quoted strings, in proper Perl syntax:
./ch-1.pl '([["Bob","Sam","Steve"],["Bill","Susan","Bob"]],[["兔","狗","猫"],["猫","猪","狗"]])'

Output is to STDOUT and will be each pair of string sets followed by the corresponding set of items in-common.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   use List::Util qw( uniq );
   # What strings do a pair of string sets have in-common?
   sub common ($aref1, $aref2) {
      my %occurrences1; for (@$aref1) {++$occurrences1{$_}}
      my %occurrences2; for (@$aref2) {++$occurrences2{$_}}
      my @combined = uniq sort (@$aref1, @$aref2);
      my @common = ();
      for (@combined) {
         if (defined $occurrences1{$_}
          && defined $occurrences2{$_}) {
            push @common, $_;
         }
      }
      return @common;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [
      ["perl", "weekly", "challenge"],
      ["raku", "weekly", "challenge"],
   ],
   # Expected output: 2

   # Example #2 inputs:
   [
      ["perl", "raku", "python"],
      ["python", "java"],
   ],
   # Expected output: 1

   # Example #3 inputs:
   [
      ["guest", "contribution"],
      ["fun", "weekly", "challenge"],
   ],
   # Expected output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $aref1 = $aref->[0];
   my $aref2 = $aref->[1];
   my @common = common($aref1,$aref2);
   my $n = scalar(@common);
   say "First  string set = (@$aref1)";
   say "Second string set = (@$aref2)";
   say "Found $n common strings:";
   say "Common string set = (@common)";
}
