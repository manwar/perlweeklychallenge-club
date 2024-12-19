#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 300-1,
written by Robbie Hatley on Mon Dec 16, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 300-1: Beautiful Arrangements
Submitted by: Mohammad Sajid Anwar
Description re-written by Robbie Hatley for clarity:
Given a positive integer n, write a script to return the number
of "beautiful arrangements" within the set of permutations of the
sequence (1..n). A 1-indexed permutation of (1..n) is considered
"a beautiful arrangement" if for every i (1 <= i <= n) either of
the following is true:
1) perm[i] is divisible by i
2) i is divisible by perm[i]

Example #1:
Input: $n = 2
Output: 2
1st arrangement: [1, 2]
perm[1] is divisible by i = 1
perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
perm[1] is divisible by i = 1
i=2 is divisible by perm[2] = 1

Example #2:
Input: $n = 1
Output: 1

Example #3:
Input: $n = 10
Output: 700

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Other than the hassle of having to generate all of the permutations of (1..n), then counting how many of them
are "beautiful arrangements", this is conceptually straightforward, if a bit complex (O(n!)). One snag is the
requirement for "1-indexed", but I'll handle that by just unshifting the string "dummy" to the left end of
every permutation. And to generate the permutations, I'll use the non-OOP "permute" function from CPAN module
"Math::Combinatorics".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of postive integers in the interval [1,10], in proper Perl syntax, like so:
./ch-1.pl '(2,4,6,8)'

Output is to STDOUT and will be each $n followed by the count of "beautiful" permutations of 1..$n.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use Math::Combinatorics;

   # How many of the permutations of (1..n) are "beautiful arrangements"?
   sub count_beautiful ($n) {
      # Get all permutations of (1..$n):
      my @perms = permute(1..$n);
      # Switch from 0-indexing to 1-indexing by unshifting a "dummy"
      # element to the left end of all permutations, thus shifting
      # the indexes of all elements one right:
      unshift(@$_, "dummy") for @perms;
      # Create and initialize a "beautiful" counter:
      my $bcount = 0;
      # Riffle through all permutations, counting "beautiful" ones:
      PERM: for my $perm (@perms) {
         for my $i (1..$n) {
            if (0 != $$perm[$i]%$i && 0 != $i%$$perm[$i]) {
               # This permutation is ugly, so don't count it:
               next PERM;
            }
         }
         # If we get to here, this permutation is "beautiful":
         ++$bcount;
      }
      return $bcount;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : (2,  1,  10);
#                Expected outputs :  2,  1, 700

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for (@ints) {
   say '';
   my $n = $_;
   say "Number = $n";
   my $bcount = count_beautiful($n);
   say "Number of beautiful arrangements = $bcount";
}
