#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 301-1,
written by Robbie Hatley on Mon Dec 23, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 301-1: Largest Number
Submitted by: Mohammad Sajid Anwar
You are given a list of positive integers, @ints. Write a script
to arrange all the elements in the given list such that they form
the largest number and return it.

Example #1:
Input: @ints = (20, 3)
Output: 320

Example #2:
Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
While it's tempting to just "sort and join", while that would work with some numbers (eg, Example #1), it
wouldn't work with others (eg, Example #2). So I'll use the non-OOP "permute" function from my favorite CPAN
module, "Math::Combinatorics", to get all permutations, join each, and see which is greatest. (I'm sure there
are ways of doing this with smaller big-O, but I've got other things to do this week, so I'll go for the
Godzilla smash instead of the surgical precision.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-1.pl '([3,8,437,2264,73894],[3,23,9,385,4298],[2,11,286,37,194,87,1935,30,285,24,57,631])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.16;
   sub largest {
      join '', sort {$b.$a cmp $a.$b} @_
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ( [20, 3], [3, 30, 34, 5, 9] );
#                  Expected outputs :     320          9534330

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @numbers = @$aref;
   say "Numbers = (@numbers)";
   my $largest = largest(@numbers);
   say "Largest Combined Number = $largest";
}
