#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 336-2,
written by Robbie Hatley on Mon Aug 25, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 336-2: Final Score
Submitted by: Mohammad Sajid Anwar
You are given an array of scores by a team. Write a script to
find the total score of the given team. The score can be any
integer, +, C or D. The + adds the sum of previous two scores.
The score C invalidates the previous score. The score D will
double the previous score.

Example #1:
Input: @scores = ("5","2","C","D","+")
Output: 30
Round 1: 5
Round 2: 5 + 2
Round 3: 5 (invalidate the previous score 2)
Round 4: 5 + 10 (double the previous score 5)
Round 5: 5 + 10 + 15 (sum of previous two scores)
Total Scores: 30

Example #2:
Input: @scores = ("5","-2","4","C","D","9","+","+")
Output: 27
Round 1: 5
Round 2: 5 + (-2)
Round 3: 5 + (-2) + 4
Round 4: 5 + (-2) (invalidate the previous score 4)
Round 5: 5 + (-2) + (-4) (double the previous score -2)
Round 6: 5 + (-2) + (-4) + 9
Round 7: 5 + (-2) + (-4) + 9 + 5 (sum of previous two scores)
Round 8: 5 + (-2) + (-4) + 9 + 5 + 14 (sum of previous two scores)
Total Scores: 27

Example #3:
Input: @scores = ("7","D","D","C","+","3")
Output: 45
Round 1: 7
Round 2: 7 + 14 (double the previous score 7)
Round 3: 7 + 14 + 28 (double the previous score 14)
Round 4: 7 + 14 (invalidate the previous score 28)
Round 5: 7 + 14 + 21 (sum of previous two scores)
Round 6: 7 + 14 + 21 + 3
Total Scores: 45

Example #4:
Input: @scores = ("-5","-10","+","D","C","+")
Output: -55
Round 1: (-5)
Round 2: (-5) + (-10)
Round 3: (-5) + (-10) + (-15) (sum of previous two scores)
Round 4: (-5) + (-10) + (-15) + (-30) (double the previous score -15)
Round 5: (-5) + (-10) + (-15) (invalidate the previous score -30)
Round 6: (-5) + (-10) + (-15) + (-25) (sum of previous two scores)
Total Scores: -55

Example #5:
Input: @scores = ("3","6","+","D","C","8","+","D","-2","C","+")
Output: 128
Round  1: 3
Round  2: 3 + 6
Round  3: 3 + 6 + 9 (sum of previous two scores)
Round  4: 3 + 6 + 9 + 18 (double the previous score 9)
Round  5: 3 + 6 + 9 (invalidate the previous score 18)
Round  6: 3 + 6 + 9 + 8
Round  7: 3 + 6 + 9 + 8 + 17 (sum of previous two scores)
Round  8: 3 + 6 + 9 + 8 + 17 + 34 (double the previous score 17)
Round  9: 3 + 6 + 9 + 8 + 17 + 34 + (-2)
Round 10: 3 + 6 + 9 + 8 + 17 + 34 (invalidate the previous score -2)
Round 11: 3 + 6 + 9 + 8 + 17 + 34 + 51 (sum of previous two scores)
Total Scores: 128

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll iterate through the partial scores from left to right, replacing each with an integer, depending on what
each partial score is saying to do. I'll use "switch" and "case" from CPAN module "Switch" to select actions
based on each partial score. Then when all partial scores have been converted to integers, I'll use "sum0"
from CPAN module "List::Util" to sum the integers, giving the final score.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["3","-5","D","bat","C","73"],["3","92","-47","D","D","D","1117846","C"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Switch;
   use List::Util 'sum0';
   # Calculate the final score:
   sub final_score ($aref) {
      # Make a working copy of our partial scores:
      my @ps = @$aref;
      # For each partial score, replace it with an integer:
      for ( my $idx = 0 ; $idx <= $#ps ; ++$idx ) {
         switch ($ps[$idx]) {
            # If item is quoted integer, just add 0:
            case /^-[1-9]\d*$|^0$|^[1-9]\d*$/ {
               $ps[$idx]=0+$ps[$idx]}
            # Add previous two:
            case "+" {
               switch ($idx) {
                  case 0 {$ps[$idx]=0}
                  case 1 {$ps[$idx]=$ps[0]}
                  else   {$ps[$idx]=$ps[$idx-2]+$ps[$idx-1]}}}
            # Cancel previous:
            case "C" {
               switch ($idx) {
                  case 0 {splice @ps,0,1;--$idx}
                  else   {splice @ps,$idx-1,2;$idx-=2}}}
            # Double previous:
            case "D" {
               switch ($idx) {
                  case 0 {$ps[$idx]=0}
                  else   {$ps[$idx]=2*$ps[$idx-1]}}}
            # Elide invalid partial scores:
            else {splice @ps,$idx,1;--$idx}}}
      # Tally and return the final score:
      sum0 @ps}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["5","2","C","D","+"],                          # Expected final score: 30
   ["5","-2","4","C","D","9","+","+"],             # Expected final score: 27
   ["7","D","D","C","+","3"],                      # Expected final score: 45
   ["-5","-10","+","D","C","+"],                   # Expected final score: -55
   ["3","6","+","D","C","8","+","D","-2","C","+"], # Expected final score: 128
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Partial scores = (@$aref)";
   my $fs = final_score($aref);
   say "Final score = $fs";
}
