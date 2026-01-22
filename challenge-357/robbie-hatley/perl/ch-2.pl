#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 357-2,
written by Robbie Hatley on Mon Jan 19, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 357-2: Unique Fraction Generator
Submitted by: Yary
Given a positive integer N, generate all unique fractions you
can create using integers from 1 to N and follow the rules below:
- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator

Example 1
Input: $int = 3
Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2
Input: $int = 4
Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3
Input: $int = 1
Output: 1/1

Example 4
Input: $int = 6
Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1

Example 5
Input: $int = 5
Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
We need only include integers (n/1), minimal fractions (1/m), and lowest-form fractions (n/m where
0!=n%m and 0!=m%n), because due to the way the problem is written, if a non-lowest fraction n/m exists,
its lowest form will also.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of positive integers, in proper Perl syntax, like so:

./ch-2.pl '(8,9,10,11)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Given a positive integer i, return all unique
   # lowest-form fractions n/m (for n, m in 1..i)
   # in increasing numeric order:
   sub unique_fractions ( $i ) {
      return () if $i !~ m/^[1-9]\d*$/;
      my @fractions;
      foreach    my $n (1..$i) {
         foreach my $m (1..$i) {
            push @fractions, [$n,$m]
            if 1==$n || 1==$m || (0!=$n%$m && 0!=$m%$n)
         }
      }
      sort {$a->[0]/$a->[1] <=> $b->[0]/$b->[1]} @fractions;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   3,
   # Expected output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

   # Example 2 input:
   4,
   # Expected output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

   # Example 3 input:
   1,
   # Expected output: 1/1

   # Example 4 input:
   6,
   # Expected output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
   #                  4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
   #                  5/2, 3/1, 4/1, 5/1, 6/1

   # Example 5 input:
   5,
   # Expected output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
   #                  5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $int (@ints) {
   say '';
   say "Integer = $int";
   my @fractions = unique_fractions($int);
   my @strings   = map {$_->[0].'/'.$_->[1]} @fractions;
   my $joined    = join ', ', @strings;
   say "Fractions = $joined";
}
