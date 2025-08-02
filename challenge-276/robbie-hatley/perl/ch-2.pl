#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 276-2,
written by Robbie Hatley on Sun Jun 30, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 276-2: Maximum Frequency
Submitted by: Mohammad Sajid Anwar
Given an array of positive integers, write a script to return
the total number of elements in the given array which have the
highest frequency.

Example 1 input:
[1, 2, 2, 4, 1, 5],
Expected output: 4
The maximum frequency is 2.
The elements 1 and 2 has the maximum frequency.

Example 2 input:
[1, 2, 3, 4, 5],
Expected output: 5
The maximum frequency is 1.
The elements 1, 2, 3, 4 and 5 has the maximum frequency.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this, I used "frequency" from "List::MoreUtils" to get a flat list of item->frequency pairs, then I
used "pairs" from "List::Util" to convert the flat list into a list of pairs, then I used
"sort {$b->[1]<=>$a->[1]}" to put the pairs in inverse order of frequency. I then tallied-up the
frequencies of the items having maximum frequency.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-2.pl '([83, 7, 16, 5, 7], [3, 7, 8, 7, 16, 7, 54, 7], [5, 4, 5, 4, 5, 4, 3, 3])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use List::MoreUtils 'frequency';
   use List::Util 'pairs';
   sub total_items_with_maximum_frequency (@items) {
      my @pairs = pairs frequency @items;
      my @sorted = sort {$b->[1]<=>$a->[1]} @pairs;
      my $max_freq = $sorted[0]->[1];
      my $total_max_freq = 0;
      for my $pair (@sorted) {
         last if $pair->[1] != $max_freq;
         $total_max_freq += $max_freq;
      }
      $total_max_freq;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [1, 2, 2, 4, 1, 5],
   # Expected output: 4

   # Example 2 input:
   [1, 2, 3, 4, 5],
   # Expected output: 5
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @items = @$aref;
   say "Items = @items";
   my $tiwmf = total_items_with_maximum_frequency(@items);
   say "Total items with maximum frequency = $tiwmf";
}
