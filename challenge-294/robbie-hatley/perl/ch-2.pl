#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 294-2,
written by Robbie Hatley on Wed Nov 06, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 294-2: Next Permutation
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find out the next permutation of the given array. The next
permutation of an array of integers is the next
lexicographically greater permutation of the decimal
representations of its integers.

Example 1:
Input: @ints = (1, 2, 3)
Output: (1, 3, 2)
Permutations of (1, 2, 3) arranged lexicographically:
(1, 2, 3)
(1, 3, 2)
(2, 1, 3)
(2, 3, 1)
(3, 1, 2)
(3, 2, 1)

Example 2:
Input: @ints = (2, 1, 3)
Output: (2, 3, 1)

Example 3:
Input: @ints = (3, 1, 2)
Output: (3, 2, 1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
After doing some researching, I found a method of finding "the lexicographically 'next' permutation" of a
list of strings which doesn't need to generate all of the permutations, just the "next". It goes like this:

1. Find the "pivot", which is the rightmost index i such that array[i] lt array[i-1].
2. Find the "successor", which is the rightmost index j such that array[j] gt array[i].
3. Swap the pivot and the successor.
4. Reverse the "suffix", which is the part to the right of the pivot.

Note that in the above I use "lt" and "gt" instead of "<" and ">". This is because the problem specifies the
"lexicographical" next permutation, as opposed to the "numerical" next permutation which would have used
"<" and ">" instead. Note, for example, that 123 is lexicographically less than 34 (because "1" is less than
"3"), and "Robbie" is lexicographically less than "girl" (because "R" is less than "g", because the capital
letters have lower ASCII/iso-8859-1/Unicode codepoints than the small letters). If the problem had specified
"numerical" or "natural" or "Unicode collation", those would have resulted in different collation orders.
But I'm interpreting "lexicographical" as meaning "Unicode codepoint order", which is what "lt" and "gt" do.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of number and/or strings, in proper Perl syntax, like so:
./ch-2.pl '([],[42],[3,2,1],[8,1164,7,3,5],[8,1164,7,5,3],["she","Bob","he","Susan"])'

Output is to STDOUT and will be each array followed by its next permutation.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.16;
   use utf8;
   $"=', ';

   # Get the "next permutation" of an array:
   sub next_permutation {
      # Get a copy of the original array:
      my @array = @_;
      # If this array is empty, it's its own "next permutation":
      if ( 0 == scalar(@array) ) {return -2, (@array);}
      # If this array only has one element, it's its own "next permutation":
      if ( 1 == scalar(@array) ) {return -1, (@array);}
      # Find the pivot, if any:
      my $pivot = -1;
      for my $i (reverse 0..$#array-1) {
         if ($array[$i] lt $array[$i+1]) {
            $pivot = $i;
            last;
         }
      }
      # If there is no pivot, this is the last permutation, so next is first:
      if (-1 == $pivot) {return 0, (reverse @array);}
      # Find the successor:
      my $successor = -1;
      for my $j (reverse $pivot+1..$#array) {
         if ($array[$j] gt $pivot) {
            $successor = $j;
            last;
         }
      }
      # If there is no successor, something disastrous has happened:
      if (-1 == $successor) {return -3, ();}
      # Swap pivot and successor:
      my $temp = $array[$pivot];
      $array[$pivot] = $array[$successor];
      $array[$successor] = $temp;
      # Reverse the suffix (the part to the right of the pivot):
      @array[$pivot+1..$#array] = reverse @array[$pivot+1..$#array];
      # Return next permutation:
      return 1, (@array);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 2, 3], # Expected output: (1, 3, 2)
   [2, 1, 3], # Expected output: (2, 3, 1)
   [3, 1, 2], # Expected output: (3, 2, 1)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   say "Array = (@array)";
   my ($code, @next) = next_permutation(@array);
   if    (-3 == $code) {say 'Error: no successor in subroutine "next_permutation".';}
   elsif (-2 == $code) {say 'Warning: array is empty, so it\'s its own "next permutation".';
                        say "\"Next\" (empty) permutation = (@next)";}
   elsif (-1 == $code) {say 'Warning: array only has one element, so it\'s its own "next permutation".';
                        say "\"Next\" (single-element) permutation = (@next)";}
   elsif ( 0 == $code) {say 'Warning: array is its own last permutation, so "next" is first.';
                        say "\"Next\" (first) permutation = (@next)";}
   elsif ( 1 == $code) {say "Next permutation = (@next)";}
   else                {say 'Error: invalid return code from subroutine "next_permutation".';}
}
