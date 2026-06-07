#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 376-1,
written by Robbie Hatley on Mon Jun 01, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 376-1: Chessboard Squares
Submitted by: Mohammad Sajid Anwar
Write a script to determine if two chess-board squares (specified
by standard chess notation) have the same color.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I query whether the sum of the first coordinate pair and the sum of the second
coordinate pair have the same modulo 2.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
arguments which must be double-quoted 4-character strings, with each string being a pair of chess coordinates
such as "c6f7", in proper Perl syntax, like so:

./ch-1.pl "a1h8" "b4d5"

Output is to STDOUT and will be each input followed by its corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Are two chessboard squares the same color?
   sub same_color ( $x ) {
      return 'Error' if $x !~ m/^[a-h][1-8][a-h][1-8]$/;
      (ord(substr($x,0,1))+substr($x,1,1))%2 ==
      (ord(substr($x,2,1))+substr($x,3,1))%2
      ? 'True' : 'False';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @pairs = @ARGV ? @ARGV : ("a7f4","c1e8","b5h2","f3h1","a1g8");
#        Expected outputs :   true   false  false  true   false

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $pair (@pairs) {
   say '';
   my $sq1  = substr($pair, 0, 2);
   my $sq2  = substr($pair, 2, 2);
   my $same = same_color($pair);
   say "Are $sq1 and $sq2 the same color? $same.";
}
