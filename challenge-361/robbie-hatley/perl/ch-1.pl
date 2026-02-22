#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 361-1,
written by Robbie Hatley on Sun Feb 22, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 361-1: Zeckendorf Representation
Submitted by: Mohammad Sajid Anwar
You are given a positive integer (<= 100). Write a script to
return Zeckendorf Representation of the given integer.
Every positive integer can be uniquely represented as sum of
non-consecutive Fibonacci numbers.

Example 1
Input: $int = 4
Output: 3,1
4 => 3 + 1 (non-consecutive Fibonacci numbers)

Example 2
Input: $int = 12
Output: 8,3,1
12 => 8 + 3 + 1

Example 3
Input: $int = 20
Output: 13,5,2
20 => 13 + 5 + 2

Example 4
Input: $int = 96
Output: 89,5,2
96 => 89 + 5 + 2

Example 5
Input: $int = 100
Output: 89,8,3
100 => 89 + 8 + 3

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll greedily gobble Fibonacci numbers from $int until it becomes zero, then return
the numbers gobbled.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of positive integers, in proper Perl syntax, like so:

./ch-1.pl '(13, 54, 82)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   $"=', ';

   # Zeckendorf:
   sub Zeckendorf ( $n ) {
      # Create output array:
      my @out;

      # Get the Fibonacci numbers from 1 through $n:
      my @fib = (1, 1, 2);
      while ( $fib[-1] < $n ) {
         push @fib, $fib[-1] + $fib[-2];
      }

      # Greedily gobble Fibonacci numbers from $n and store in @out:
      my $i = -1;
      while ($n) {
         if ( $i < -scalar(@fib) ) {
            die "Error: \$i is $i which is out-of-range.\n$!\n";
         }
         if ( $fib[$i] <= $n ) {
            $n -= $fib[$i];
            push @out, $fib[$i];
         }
         --$i;
      }

      # Return the result:
      @out;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) :
(
     4, # Expected output: (3, 1)
    12, # Expected output: (8, 3, 1)
    20, # Expected output: (13, 5, 2)
    96, # Expected output: (89, 5, 2)
   100, # Expected output: (89, 8, 3)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $int (@ints) {
   say '';
   say "Integer = $int";
   my @Zeckendorf = Zeckendorf($int);
   say "Zeckendorf representation = (@Zeckendorf)";
}
