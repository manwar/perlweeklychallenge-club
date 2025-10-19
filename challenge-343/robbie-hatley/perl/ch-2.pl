#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 343-2,
written by Robbie Hatley on Wed Oct 15, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 343-2: Champion Team
Submitted by: Mohammad Sajid Anwar
You have n teams in a tournament. A matrix grid tells you which
team is stronger between any two teams:
If grid[i][j] == 1, then team i is stronger than team j
If grid[i][j] == 0, then team j is stronger than team i
Find the champion team - the one with most wins, or if there is
no single such team, the strongest of the teams with most wins.
(You may assume that there is a definite answer.)

Example #1:
Input:           [0, 1, 1],
                 [0, 0, 1],
                 [0, 0, 0],
Expected output: Team 0

Example #2:
Input:           [0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0],
Expected output: Team 3

Example #3:
Input:           [0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0],
Expected output: Team 0

Example #4:
Input:           [0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0],
Expected output: Team 0

Example #5
Input:           [0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0],
Expected output: Team 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Note: Even though the description says "You may assume that there is a definite answer.", that's just not so.
For example, there may be three teams with maximum number of wins each, with A beating B, B beating C, and
C beating A. That would be a tie. So as tie-breaker, I'll give rapidly-increasing bonuses for beating higher-
ranking teams. I'll start my making an array @w of wins. Then I'll make an array @s of scores with each team's
score being its number of wins plus a bonus for each team beaten consisting of one billionth times w**w
where w is the number-of-wins of the beaten team. For example, if a team beats one rank 2 team, one rank 3
team, and one rank 4 team, then its score will be (3 + 1E-9*2**2 + 1E-9*3**3 + 1E-9*4**4). Finally, I'll
return the index of the first team found with max score. (Thus team order is ultimate tie breaker.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of ones and zeros, in proper Perl syntax, like so:

./ch-2.pl '([[1,0,1],[0,1,0],[1,1,0],],[[0,1,1],[1,0,1],[1,1,0]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'sum0';

   # Which team is champion?
   sub champ ($aref) {
      my @w;                                # Wins.
      my @s;                                # Scores.
      for (0..$#$aref) {                    # For each index.
         push @w, sum0(@{$$aref[$_]})}      # Accumulate wins.
      for my $row (0..$#$aref) {            # For each row.
         my @row_scores;                    # Scores for this row.
         for my $col (0..$#$aref) {         # For each column.
            my $w = $aref->[$row]->[$col];  # Wins for this cell.
            my $r = $w[$col];               # Rank of opponent.
            my $s = $w * (1 + 1E-9*$r**$r); # Score for this cell.
            push @row_scores, $s}           # Push cell score to array.
         push @s, sum0(@row_scores)}        # Push row score to scores.
      my $max_idx = 0;                      # Index of first max score.
      my $max_scr = 0;                      # Value of first max score.
      for my $scr_idx (0..$#$aref) {        # For each score.
         if ($s[$scr_idx] > $max_scr) {     # If score is greater than max.
            $max_idx = $scr_idx;            # Update max index.
            $max_scr = $s[$scr_idx]}}       # Update max value.
      $max_idx}                             # Return max index.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [
      [0, 1, 1],
      [0, 0, 1],
      [0, 0, 0],
   ],
   # Expected output: Team 0

   # Example #2 input:
   [
      [0, 1, 0, 0],
      [0, 0, 0, 0],
      [1, 1, 0, 0],
      [1, 1, 1, 0],
   ],
   # Expected output: Team 3

   # Example #3 input:
   [
      [0, 1, 0, 1],
      [0, 0, 1, 1],
      [1, 0, 0, 0],
      [0, 0, 1, 0],
   ],
   # Expected output: Team 0

   # Example #4 input:
   [
      [0, 1, 1],
      [0, 0, 0],
      [0, 1, 0],
   ],
   # Expected output: Team 0

   # Example #5 input:
   [
      [0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 0, 1, 1],
      [1, 1, 0, 0, 0],
      [1, 1, 0, 1, 0],
   ],
   # Expected output: Team 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Team wins:";
   for (0..$#$aref) {
      say "[@{$$aref[$_]}]";
   }
   my $c = champ($aref);
   say "Index of champion team = $c";
}
