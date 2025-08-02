#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 289-1,
written by Robbie Hatley on Sun Sep 29, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 289-1: "Third Maximum"
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find the third distinct maximum in the given array. If third
maximum doesn’t exist then return the maximum number.

Example 1:
Input: @ints = (5, 6, 4, 1)
Output: 4
The first distinct maximum is 6.
The second distinct maximum is 5.
The third distinct maximum is 4.

Example 2:
Input: @ints = (4, 5)
Output: 5
In the given array, the third maximum doesn't exist, therefore
return the maximum.

Example 3:
Input: @ints =  (1, 2, 2, 3)
Output: 1
The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Function "uniq" from CPAN module "List::Util" will be very useful here.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([-3,8,5,-1,9],[])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.16;
use List::Util 'uniq';
sub third_maximum {
   my $aref = shift @_;
   my @uniq = uniq sort {$b<=>$a} @{$aref};
   if    (scalar(@uniq) >= 3) {return $uniq[2];}
   elsif (scalar(@uniq) >= 1) {return $uniq[0];}
   else                       {return 'undef';}
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([5, 6, 4, 1],[4, 5],[1, 2, 2, 3]);
# Expected output:                          4          5         1

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my $third_max = third_maximum($aref);
   say '';
   say "Array = (@$aref)";
   say "Third maximum = $third_max"
}
