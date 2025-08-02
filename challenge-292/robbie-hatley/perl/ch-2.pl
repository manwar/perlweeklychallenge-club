#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 292-2,
written by Robbie Hatley on Mon Oct 21, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 292-2: Zuma Game
Submitted by: Mohammad Sajid Anwar
You are given a single row of colored balls, $row, and a random
number of colored balls in $hand.

Here is the variation of Zuma Game. Your goal is to clear all of
the balls from the row. Pick any ball from your hand and insert
it in between two balls in the row or on either end of the row.
If there is a group of three or more consecutive balls of the
same color then remove the group of balls from the row. If
there are no more balls on the row then you win the game.
Repeat this process until you either win or do not have any more
balls in your hand.

Write a script to determine the minimum number of balls you need
to insert to clear all the balls from the row. If you cannot
clear all the balls from the row using the balls in your hand,
return -1.

Example 1:
Input: $row = "WRRBBW", $hand = "RB"
It is impossible to clear all the balls. The best you can do is:
- Insert 'R' so the row becomes WRRRBBW. WRRRBBW -> WBBW.
- Insert 'B' so the row becomes WBBBW. WBBBW -> WW.
There are still balls remaining on the row,
and you are out of balls to insert,
so Output = -1.

Example 2:
Input: $row = "WWRRBBWW", $hand = "WRBRW"
To make the row empty:
- Insert 'R' so the row becomes WWRRRBBWW -> WWBBWW
- Insert 'B' so the row becomes WWBBBWW   -> WWWW -> empty
2 balls from your hand were needed to clear the row,
so Output = 2.

Example 3:
Input: $row = "G", $hand = "GGGGG"
To make the row empty:
- Insert 'G' so the row becomes GG.
- Insert 'G' so the row becomes GGG. GGG -> empty.
2 balls from your hand were needed to clear the row,
so Output = 2.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I don't know about "minimum" (which would require elaborate mathematical proofs), but I can certainly come up
with an algorithm which makes "good effort" towards removing all the balls. I use this approach:
1. Sort hand in increasing order of abundance of each hand ball in row. (I do this because highly-abundant
   colors in row tend to self-destruct after less-abundant intermediaries are removed.)
2. Process all balls in sorted hand from left to right.
3. For each ball in hand:
      If there are two contiguous balls of that color on row, insert to their right.
      Else if there is 1 ball of that color on row, insert to its right.
      Else don't use current hand ball (as this would be counterproductive).
      Keep count of how many hand balls were added to row.
      Remove any contiguous clusters of 3-or-more balls from hand.
      Stop processing hand balls if row is now empty.
4. If row is now empty, we win, so return number of hand balls used;
   otherwise, we lose, so return -1.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '(["RWPGPGPG", "RRWWPGPGPGPGPGPG"],["RWPGPGPG", "RRWWPGPGPGPG"])'
(You can use any characters you like; each variety of character will be interpretted as representing a color.)

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;

   # What is the abundance of a given character in a given string?
   sub abundance ($str, $chr) {
      my $a = 0;
      for my $idx (0..length($str)) {
         if (substr($str,$idx,1) eq $chr) {++$a}
      }
      $a;
   }

   # Try to clear colors from row using balls from hand:
   sub clear_colors ($row, $hnd) {
      # Sort hand in increasing order of abundance of each hand ball in row; I do this because highly-
      # abundant colors in row tend to self-destruct after less-abundant intermediaries are removed:
      $hnd = join '', sort {abundance($row,$a)<=>abundance($row,$b)} split '', $hnd;
      # Count of hand balls used:
      my $hand_balls_used = 0;
      # Process each ball in $hnd from left to right:
      foreach my $i (0..length($hnd)-1) {
         # If we find two contiguous matching balls in $row, tack current hand ball to their right:
         foreach my $j (0..length($row)-2) {
            if ( substr($row,$j+0,1) eq substr($hnd,$i,1) && substr($row,$j+1,1) eq substr($hnd,$i,1) ) {
               substr($row,$j,2,substr($row,$j,2).substr($hnd,$i,1));
               ++$hand_balls_used; goto REMOVE;
            }
         }

         # If we find one matching ball in $row, tack current hand ball to its right:
         foreach my $j (0..length($row)-1) {
            if ( substr($row,$j,1) eq substr($hnd,$i,1) ) {
               substr($row,$j,2,substr($row,$j,2).substr($hnd,$i,1));
               ++$hand_balls_used; goto REMOVE;
            }
         }

         # If we get to here, don't add current hand ball to row as that would be counterproductive:
         ; # Do nothing.

         # Remove all contiguous blocks of 3-or-more identical balls from row:
         REMOVE:
         $row =~ s/(.)(\1){2,}//g;

         # Stop processing hand if we've cleared row:
         last if '' eq $row;
      }
      # If row is now empty, return hand balls used:
      if ( '' eq $row ) {return $hand_balls_used}
      # Otherwise, return -1:
      return -1;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : (["WRRBBW","RB"],["WWRRBBWW","WRBRW"],["G","GGGGG"]);
#                  Expected outputs :          -1               2                 2

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my $row = $$aref[0];
   my $hnd = $$aref[1];
   my $rslt = clear_colors($row,$hnd);
   say '';
   say "Row = $row";
   say "Hnd = $hnd";
   $rslt > -1
   and say "Balls used to clear row = $rslt"
   or  say "Unable to clear row.";
}
