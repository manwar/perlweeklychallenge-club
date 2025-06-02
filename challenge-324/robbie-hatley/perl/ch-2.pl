#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 324-2,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 324-2: Total XOR
Submitted by: Mohammad Sajid Anwar
You are given an array of integers [in the range 0-255].
Write a script to return the sum of total XOR for every
subset of given array.

Example #1:
Input: @ints = (1, 3)
Output: 6
Subset [1],    total XOR = 1
Subset [3],    total XOR = 3
Subset [1, 3], total XOR => 1 XOR 3 => 2
Sum of total XOR => 1 + 3 + 2 => 6

Example #2:
Input: @ints = (5, 1, 6)
Output: 28
Subset [5],       total XOR = 5
Subset [1],       total XOR = 1
Subset [6],       total XOR = 6
Subset [5, 1],    total XOR => 5 XOR 1 => 4
Subset [5, 6],    total XOR => 5 XOR 6 => 3
Subset [1, 6],    total XOR => 1 XOR 6 => 7
Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2
Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example #3:
Input: @ints = (3, 4, 5, 6, 7, 8)
Output: 480

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

This problem, as originally written, did not contain the phrase "in the range 0-255", so it was too vague to
be answered, because there is no fixed way to represent "any integer" using a fixed, finite number of binary
bits. So I added the specification "[in the range 0-255]".

Now we are left with two issues:

Firstly, compute all subsets of our input set. I'll do this by using the "combine" function from CPAN module
"Math::Combinatorics" to obtain all n-combinations of the input, for all values of n from 0 through the size
of the input.

Secondly, compute the n-ary bit-wise XOR of each subset. I'll do this by making a subroutine which
recursively applies Perl's "^" bitwise-XOR operator.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["rat", "bat", "cat"],["pig", "cow", "horse"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Math::Combinatorics 'combine';

   # n-ary XOR:
   sub NARY_XOR (@a) {
      my $n = scalar @a;                     # Number of operands.
      if    (0 == $n) {return 0;}            # 0 operands => return 0.
      elsif (1 == $n) {return $a[0]}         # 1 operand  => return operand.
      elsif (2 == $n) {return $a[0] ^ $a[1]} # 2 operands => return x ^ y
      else {                                 # For more-than-2 operands,
         my $x = shift @a;                   # return the result of
         return $x ^ NARY_XOR(@a)}}          # FirstOperand ^ (XOR of remaining operands)

   # n-ary TOTAL_XOR:
   sub TOTAL_XOR (@a) {
      my $n = scalar @a;              # n is the number of elements in set @a.
      my @power_set;                  # The "power set" of a set @a is the set of all of its subsets.
      for my $i (0..$n) {             # The "power set" of a set @a is ALSO the set of all i-combinations
         my @ncombs = combine($i,@a); # of elements of @a for all numbers i from 0 through n.
         push @power_set, @ncombs}    # The number of subsets in the power set is always 2^n.
      my $total = 0;                  # Total of n-ary XORs of all elements of @power_set.
      foreach my $aref (@power_set) { # For each subset in power set,
         $total += NARY_XOR(@$aref)}  # add its n-ary XOR to our total.
      return $total}                  # Return total.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 3],             # Expected output =   6
   [5, 1, 6],          # Expected output =  28
   [3, 4, 5, 6, 7, 8], # Expected output = 480
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $TXOR = TOTAL_XOR(@$aref);
   say "TXOR  = $TXOR";
}
