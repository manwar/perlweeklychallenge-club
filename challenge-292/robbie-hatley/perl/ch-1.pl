#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 292-1,
written by Robbie Hatley on Mon Oct 21, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 292-1: Twice Largest
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, where the largest
integer is unique. Write a script to find whether the largest
element in the array is at least twice as big as every other
element in the array. If it is, return the index of the largest
element; else return -1.

Example 1:
   Input:  (2, 4, 1, 0)
   The largest integer is 4 (with index 1), and it as at-least
   twice as large as every other element, so return its index, 1.

Example 2:
   Input:  (1, 2, 3, 4)
   The largest integer is 4, but it's less than twice as large as
   the next-largest number, 3; so return -1.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of reverse-numeric-sorting the array then determining whether-or-not the largest element
(0th element of sorted array) is at-least-twice-as-large-as the second-largest element (1st element of sorted
array).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([6,-8,18,7],[5,6,7,8])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.38;

# Is the largest element of an array of integers
# at least twice the next-largest element?
sub twice_or_more ($aref) {
   my @sorted = sort {$b<=>$a} @$aref;
   my $lv = $sorted[0] ; # Largest Value
   my $li = -1         ; # Largest Index
   my $sv = $sorted[1] ; # Second  Value
   my $si = -1         ; # Second  Index
   my $tl =  0         ; # Twice as Large?
   for my $idx (0..$#$aref) {if ($$aref[$idx] == $lv) {$li = $idx;last}}
   for my $idx (0..$#$aref) {if ($$aref[$idx] == $sv) {$si = $idx;last}}
   if ($lv >= 2*$sv) {$tl = 1}
   return ($lv,$li,$sv,$si,$tl);
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([2,4,1,0],[1,2,3,4]);
#                  Expected outputs :     1         -1

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my ($lv,$li,$sv,$si,$tl) = twice_or_more($aref);
   say '';
   say "Array = (@$aref)";
   say "Largest value (LV) is $lv at index $li.";
   say "Second  value (SV) is $sv at index $si.";
   say $tl ? "LV >= 2 * SV" : "LV  < 2 * SV";
}
