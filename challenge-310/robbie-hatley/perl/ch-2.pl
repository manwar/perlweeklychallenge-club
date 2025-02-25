#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 310-2,
written by Robbie Hatley on Mon Feb 24, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 310-2: Sort Odd Even
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to sort odd
index elements in decreasing order and even index elements in
increasing order in the given array.

Example #1:
Input: @ints = (4, 1, 2, 3)
Output: (2, 3, 4, 1)
Even index elements: 4, 2 => 2, 4 (increasing order)
Odd index elements : 1, 3 => 3, 1 (decreasing order)

Example #2:
Input: @ints = (3, 1)
Output: (3, 1)

Example #3:
Input: @ints = (5, 3, 2, 1, 4)
Output: (2, 3, 4, 1, 5)
Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
Odd index elements : 3, 1 => 3, 1 (decreasing order)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll first separate the odd and even elements into to separate arrays, sort them separately (odds decending,
evens ascending), then use the "mesh" function from CPAN module "List::SomeUtils" to mesh them together.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl '([1,3,8,17,-8,24,3,-42],[1,2,3,4,5,6,7])'

Output is to STDOUT and will be each input followed by the a version of the input with the odd-index elements
sorted in decreasing order and the even-index elements sorted in increasing order.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::SomeUtils 'mesh';

   # Sort an array of integers such that the even-index elements are in
   # increasing order and the odd-index elements are in decreasing order:
   sub even_up_odd_down ($aref) {
      my @evn_uns;
      my @odd_uns;
      for (0..$#$aref) {
         0==$_%2
         and push @evn_uns, $$aref[$_]
         or  push @odd_uns, $$aref[$_];
      }
      my @evn_srt = sort {$a<=>$b} @evn_uns;
      my @odd_srt = sort {$b<=>$a} @odd_uns;
      my @msh_srt = mesh @evn_srt, @odd_srt;
      while (!defined $msh_srt[-1]) {splice @msh_srt, -1, 1}
      return @msh_srt;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [4, 1, 2, 3   ], # Expected output: (2, 3, 4, 1)
   [3, 1         ], # Expected output: (3, 1)
   [5, 3, 2, 1, 4], # Expected output: (2, 3, 4, 1, 5)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my @s = even_up_odd_down($aref);
   say "even-up/odd-down sort = (@s)";
}
