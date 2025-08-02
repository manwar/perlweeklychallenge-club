#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 321-1,
written by Robbie Hatley on Mon May 12, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 321-1: Distinct Average
Submitted by: Mohammad Sajid Anwar
You are given an array of numbers with even length. Write a
script to return a count of distinct averages. The averages
are calculated by removing the minimum and the maximum, then
averaging the two.

Example #1:
Input: @nums = (1, 2, 4, 3, 5, 6)
Output: 1
Step 1: Min = 1, Max = 6, Avg = 3.5
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5
The count of distinct averages is 1.

Example #2:
Input: @nums = (0, 2, 4, 8, 3, 5)
Output: 2
Step 1: Min = 0, Max = 8, Avg = 4
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5
The count of distinct averages is 2.

Example #3:
Input: @nums = (7, 3, 1, 0, 5, 9)
Output: 2
Step 1: Min = 0, Max = 9, Avg = 4.5
Step 2: Min = 1, Max = 7, Avg = 4
Step 3: Min = 3, Max = 5, Avg = 4
The count of distinct averages is 2.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
After checking that each input array is, indeed, an even-length array of real numbers, I'll compute each
"Min-Max Average" by doing the following:
1. Put list in increasing numerical order.
2. Loop while @sorted is not empty:
   a. Snip-off min and max.
   a. Compute next MMA ((min+max)/2) and push it to list @MMAs.
3. Compute number of unique MMAs using "sort", "unique", and "scalar".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of even-sized arrays of numbers, in proper Perl syntax, like so:

./ch-1.pl '([],[1,2,3],[32,-64,-21,-11],[37.19,-13.24,84.62,-99.17,82.63,-3.69])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use Scalar::Util 'looks_like_number';
   use List::Util   'uniq';

   # Is a given list an even-sized list of numbers?
   sub is_even_sized_list_of_numbers (@list) {
      return 0 unless scalar(@list) > 0;                  # Reject empty lists.
      return 0 unless 0 == scalar(@list)%2;               # Reject lists with odd number of elements.
      for my $item (@list) {
         return 0 unless looks_like_number $item;         # Reject lists with any non-numeric elements.
      }
      return 1;                                           # List passes all tests.
   }

   # How many unique Min-Max Averages does
   # an even-sized list of numbers have?
   sub number_of_unique_min_max_averages (@list) {
      my @MMAs;                                           # Min-Max Averages.
      my @sorted = sort {$a<=>$b} @list;                  # Put list in increasing numerical order.
      while (@sorted) {                                   # While @sorted is not empty.
         my ($min, $max) = (shift(@sorted),pop(@sorted)); # Snip min and max from sorted list.
         push @MMAs, ($min + $max)/2;                     # Push next MMA to @MMAs.
      }                                                   # Repeat.
      scalar(uniq(sort {$a<=>$b} @MMAs));                 # Return number of unique MMAs.
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 2, 4, 3, 5, 6], # Expected output = 1
   [0, 2, 4, 8, 3, 5], # Expected output = 2
   [7, 3, 1, 0, 5, 9], # Expected output = 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "List of numbers = (@$aref)";
   if (!is_even_sized_list_of_numbers(@$aref)) {
      say STDERR "Error: Not an even-sized list of numbers; moving on to next list.";
      next;
   }
   my $noumma = number_of_unique_min_max_averages(@$aref);
   say "Number of unique Min-Max Averages = $noumma";
}
