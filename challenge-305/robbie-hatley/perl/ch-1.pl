#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 305-1,
written by Robbie Hatley on Mon Jan 20, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 305-1: "Binary Prefix"
Submitted by: Mohammad Sajid Anwar
You are given a binary array. Write a script to return an array
of booleans where the partial binary number up to that point is
prime.

Example #1:
Input: @binary = (1, 0, 1)
Output: (false, true, true)
Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime

Example #2:
Input: @binary = (1, 1, 0)
Output: (false, true, false)
Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime

Example #3:
Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0,
1, 0, 0, 0, 1)
Output: (false, true,  true,  false, false, true,  false, false,
false, false, false, false, false, false, false, false,
false, false, false, true)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
For each binary prefix, I'll apply eval to "0b" tacked to the left of the join of the slice of the prefix
in order to convert it to decimal; then I'll feed each such decimal number to an "is_prime" function to
determine its primality.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 0s and 1s, in proper Perl syntax, like so:
./ch-1.pl '([0,0,1,0,0,1,0,0,1,1,0,1,0],[1,1,1,0,0,0,1,1,1,0,0,0,1,1,1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # Is a given scalar a reference to a binary array?
   sub is_binary_array($aref) {
      return 0 unless 'ARRAY' eq ref $aref;
      return 0 unless scalar(@$aref) > 0;
      foreach my $element (@$aref) {
         return 0 unless $element eq '0' || $element eq '1';
      }
      return 1;
   }

   # Is a given scalar a prime number?
   sub is_prime($x) {
      # If $x ain't an integer then it ain't prime:
      return 0 unless $x =~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/;
      # If $x is less than 2 it ain't prime:
      return 0 if $x < 2;
      # If $x is equal to 2, it's prime:
      return 1 if 2 == $x;
      # If $x is even, it ain't prime:
      return 0 if 0 == $x%2;
      # If we get to here, $x is an odd integer > 2.
      # Get its square root:
      my $root = $x**0.5;
      # If $x is divisible by any odd integer <= $root,
      # then $x ain't prime:
      for ( my $test = 3 ; $test <= $root ; $test += 2 ) {
         return 0 if 0 == $x%$test
      }
      # If we get to here, $x isn't divisible by a damn thing,
      # so $x is prime:
      return 1;
   }

   # What are the primalities of every binary prefix
   # of the binary number given by an array of 1s & 0s?
   sub binary_prefixes_are_prime ($aref) {
      my @results = ();
      for my $size (1..scalar(@$aref)) {
         my @slice = @$aref[0..$size-1];
         my $prefix = eval("0b".join('',@slice));
         push @results, (is_prime($prefix) ? "T" : "F");
      }
      return @results;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0])
                   : ([1, 0, 1], [1, 1, 0], [1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]);
# Expected outputs :  (F, T, T)  (F, T, F)  (F, T, T, F, F, T, F, F, F, F, F, F, F, F, F, F, F, F, F, T)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Binary digits      = (@$aref)";
   if (!is_binary_array($aref)) {
      say "Error: Not a binary array.";
      next;
   }
   my @results = binary_prefixes_are_prime($aref);
   say "Prefix primalities = (@results)";
}
