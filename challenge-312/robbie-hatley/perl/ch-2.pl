#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 312-2,
written by Robbie Hatley on Mon Mar 10, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 312-2: Balls and Boxes
Submitted by: Mohammad Sajid Anwar
There are $n balls of mixed colors: red, blue or green. They are
all distributed in 10 boxes labelled 0-9. You are given a string
describing the location of balls. Write a script to find the
number of boxes containing all three colors. Return 0 if none
are found.

Example #1:
Input: $str = "G0B1R2R0B0"
Output: 1
The given string describes there are 5 balls as below:
Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
Box 1: Blue(B1) => 1 ball
Box 2: Red(R2) => 1 ball

Example #2:
Input: $str = "G1R3R6B3G6B1B6R1G3"
Output: 3
The given string describes there are 9 balls as below:
Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls

Example #3:
Input: $str = "B3B2G1B3"
Output: 0
Box 1: Green(G1) => 1 ball
Box 2: Blue(B2)  => 1 ball
Box 3: Blue(B3)  => 2 balls

--------------------------------------------------------------------------------------------------------------

PROBLEM NOTES:
I'll just make an array of boxes with one string in each box, then ".=" an R, G, or B to the appropriate box's
string for each letter/number pair, then count Frecce Tricolori strings (that is, strings which have all three
colors). All apparent allusions to Malvina Reynolds' song "Little Boxes", and to "313° Gruppo Addestramento
Acrobatico Pattuglia Acrobatica Nazionale Frecce Tricolori", and to The Ramstein Airshow Disaster, are purely
intentional. Some history should not be forgotten. (EG, we forgot Hitler then did it all over again on
5 November 2024, and now USA is controlled by a pair of mentally-unstable billionare oligarch fascists. Oops.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more arguments which must
be single-quoted strings of even length, with even-index characters being R, G, or B, and odd-index
characters being a digit. For example:
./ch-2.pl 'R3G9R5' 'R3B7G3B5B3G2G3'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # Does a given scalar contain a valid descriptor?
   sub is_valid_descriptor($x) {
      my $l = length($x);
      return 0 if 0 != $l%2;
      for my $idx (0..$l-1) {
         my $c = substr $x, $idx, 1;
         if (0 == $idx%2) {
            return 0 if $c !~ m/^[RGB]$/;
         }
         else {
            return 0 if $c !~ m/^\d$/;
         }
      }
      return 1;
   }

   # How many tricolor boxes are implied by a given descriptor?
   sub Frecce_Tricolori ($x) {
      # Little boxes on the hillside
      # Little boxes made of ticky tacky
      # Little boxes on the hillside
      # Little boxes all the same
      # There's a green one and a pink one
      # And a blue one and a yellow one
      # And they're all made out of ticky tacky
      # And they all look just the same
      my @boxes = ('','','','','','','','','','');
      for my $idx (0..length($x)/2-1) {
         $boxes[substr($x,2*$idx+1,1)] .= substr($x,2*$idx,1);
      }
      my $Ramstein = 0;
      for my $idx (0..9) {
         if ($boxes[$idx] =~ m/R/
          && $boxes[$idx] =~ m/G/
          && $boxes[$idx] =~ m/B/) {
             ++$Ramstein;
         }
      }
      return $Ramstein;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @descrs = @ARGV ? @ARGV : ("G0B1R2R0B0","G1R3R6B3G6B1B6R1G3","B3B2G1B3");
#         Expected outputs :       1                3                0

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $descr (@descrs) {
   say '';
   say "Descriptor = $descr";
   if (!is_valid_descriptor($descr)) {
      say "Error: invalid descriptor.";
      say "Moving on to next descriptor.";
      next;
   }
   my $FT = Frecce_Tricolori($descr);
   say "$FT boxes have all three colors."
}
