#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge #349-2,
written by Robbie Hatley on Wed Nov 26, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 349-2: Meeting Point
Submitted by: Mohammad Sajid Anwar
You are given instruction string made up of U (up), D (down),
L (left) and R (right). Write a script to return true if
following the instruction, you meet (0,0) at any point along
the sequence.

Example #1:
Input: $path = "ULD"
Output: false
(-1,1) <- (0,1)
   |        ^
   v        |
(-1,0)    (0,0)

Example #2:
Input: $path = "ULDR"
Output: true
 (-1,1) <- (0,1)
    |        ^
    v        |
 (-1,0) -> (0,0)

Example #3:
Input: $path = "UUURRRDDD"
Output: false
(0,3) -> (1,3) -> (2,3) -> (3,3)
  ^                          |
  |                          v
(0,2)                      (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0)                      (3,0)

Example #4:
Input: $path = "UURRRDDLLL"
Output: true
(0,2) -> (1,2) -> (2,2) -> (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0) <- (1,0) <- (1,1) <- (3,0)

Example #5:
Input: $path = "RRUULLDDRRUU"
Output: true
(0,2) <- (1,2) <- (2,2)
  |                 ^
  v                 |
(0,1)             (2,1)
  |                 ^
  v                 |
(0,0) -> (1,0) -> (2,1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Assuming that we start at (0,0), this problem is just a matter of seeing if any future point is (0,0), and if
it is, we can return 'true' immediately. If we never see (0,0) again after leaving it, then return 'false'.

One might be tempted to take this shortcut: Simply compare Us to Ds and Ls to Rs and return 'true' if equal,
'false' if not. This, however, is a mistake, because it only determines if the END point is (0,0), whereas
we want to determine if ANY point other than the first is (0,0).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '("ULULUL", "ULUURDDD", "UULLDDDRR", "ULDRU")'
The letters U, L, D, R in these strings represent Up, Left, Down, Right.
Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Switch;

   # Did we ever come home again?
   sub came_home ( $s ) {
      my ($x, $y) = (0, 0);
      my @dirs = split //, $s;
      foreach my $dir (@dirs) {
         switch ($dir) {
            case ('U') {$y++}
            case ('L') {$x--}
            case ('D') {$y--}
            case ('R') {$x++}}
         return 'True.' if 0 == $x && 0 == $y}
      return 'False.'}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("ULD", "ULDR", "UUURRRDDD", "UURRRDDLLL", "RRUULLDDRRUU");
#                   Expected outputs :  False.  True.     False.        True.          True.

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "Directions: $s";
   my $ch = came_home($s);
   say "Came home? $ch";
}
