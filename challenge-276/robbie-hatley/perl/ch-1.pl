#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 276-1,
written by Robbie Hatley on Sun Jun 30, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 276-1: Complete Day
Submitted by: Mohammad Sajid Anwar
Given an array of integers, write a script to return the number
of pairs that forms a complete day. A complete day is defined as
a time duration that is an exact multiple of 24 hours.

Example 1 input:
[12, 12, 30, 24, 24],
Expected output: 2
Pair 1: (12, 12)
Pair 2: (24, 24)

Example 2 input:
[72, 48, 24, 5],
Expected output: 3
Pair 1: (72, 48)
Pair 2: (72, 24)
Pair 3: (48, 24)

Example 3 input:
[12, 18, 24],
Expected output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of using nested 3-part loops to avoid duplicating pairs, then seeing which pairs add up
to an integer x such that 0 == x%24.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([3, -17, 24, -31, 0, 21],[5, 19, 0, 347, -82])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   sub complete_days (@times) {
      my $cds = 0;
      for    my $i (    0   .. $#times - 1 ) {
         for my $j ( $i + 1 .. $#times - 0 ) {
            0 == ($times[$i]+$times[$j])%24 and ++$cds;
         }
      }
      $cds;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [12, 12, 30, 24, 24],
   # Expected output: 2

   # Example 2 input:
   [72, 48, 24, 5],
   # Expected output: 3

   # Example 3 input:
   [12, 18, 24],
   # Expected output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @times = @$aref;
   say "Times = (@times)";
   my $cds = complete_days(@times);
   say "Complete days = $cds";
}
