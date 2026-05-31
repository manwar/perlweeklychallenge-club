#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 375-2,
written by Robbie Hatley on Sun May 31, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 375-2: Find K-Beauty
Submitted by: Mohammad Sajid Anwar
You are given a positive integer and a digit K. Write a script
to find the K-Beauty of the given integer. The K-Beauty of a
positive integer is defined as the number of substrings of the
given positive integer which both have length K and are divisors
of the given positive integer.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem is easily solved using a 3-part loop.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of a positive integer under 10 billion and a non-zero digit, in proper Perl
syntax, like so:

./ch-2.pl '([485216,1],[485216,2],[485216,3],[485216,4],[485216,5],[485216,6])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # What is the K-beauty of a given (integer, digit) pair?
   sub kb ( $integer , $digit ) {
      my $n = length($integer);
      my $k = 0;
      for ( my $idx = 0 ; $idx <= $n-$digit ; ++$idx ) {
         # Get substring at $idx with length $digit:
         my $substring = substr($integer,$idx,$digit);
         # Convert string into number:
         my $subnumber = 0 + $substring;
         # Count divisible subnumbers:
         ++$k if 0 == $integer % $subnumber;
      }
      $k;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [  240, 2 ], # Expect: 2
   [ 1020, 2 ], # Expect: 3
   [  444, 2 ], # Expect: 0
   [   17, 2 ], # Expect: 1
   [  123, 1 ], # Expect: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   if ( 2 != scalar @$aref ) {
      warn "Error: Must have two inputs, a positive Integer under 10 billion and a positive Digit.\n"
          ."Moving on to next inputs.\n";
      next;
   }
   my $i = $aref->[0];
   if ( $i !~ m/^[1-9]\d*$/ ) {
      warn "Error: Integer must be a positive integer.\n"
          ."Moving on to next inputs.\n";
      next;
   }
   if ( length($i) > 10 ) {
      warn "Error: Integer must be less than 10 billion.\n"
          ."Moving on to next inputs.\n";
      next;
   }
   my $d = $aref->[1];
   if ( $d !~ m/^[1-9]*$/ ) {
      warn "Error: Digit must be a non-zero digit..\n"
          ."Moving on to next inputs.\n";
      next;
   }
   if ( $d > length($i) ) {
      warn "Error: Digit must be no greater than length of Integer.\n"
          ."Moving on to next inputs.\n";
      next;
   }
   my $k = kb($i, $d);
   say "Integer = $i. Digit = $d. K-beauty = $k";
}
