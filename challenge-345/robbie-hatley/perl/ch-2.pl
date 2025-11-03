#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 345-2,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 345-2: Last Visitor
Submitted by: Mohammad Sajid Anwar
You are given an array @ints of integers where each element is
either a positive integer or -1. We process the array from left
to right while maintaining two lists:
@seen (stores previously-seen positive integers, newest at front)
@ans  (stores the answers for each -1)

Rules:

1. Iterate index $i from 0 to $#ints, strictly increasing.

2. If $ints[$i] is a positive integer, then insert it at the
   front of @seen.

3. If $ints[$i] is -1, let $x be how many -1s in a row we’ve seen
   before this one. If $x < len(@seen) -> append seen[$x] to @ans;
   otherwise, append -1 to @ans.

4. At the end, return @ans.

Example #1:  Input:  (5, -1, -1)
             Output: (5, -1)
             @seen = (5)
             First  -1: @ans = (5)
             Second -1: @ans = (5, -1)

Example #2:  Input:  (3, 7, -1, -1, -1)
             Output: (7, 3, -1)
             @seen = (7, 3)
             First  -1: @ans = (7)
             Second -1: @ans = (7, 3)
             Third  -1: @ans = (7, 3, -1)

Example #3:  Input: @ints = (2, -1, 4, -1, -1)
             Output: (2, 4, 2)

Example #4:  Input: @ints = (10, 20, -1, 30, -1, -1)
             Output: (20, 30, 20)

Example #5:  Input: @ints = (-1, -1, 5, -1)
             Output: (-1, -1, 5)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of doing exactly what the description says. The logic is straightforward (if a bit
perplexing) with no ambiguities, race conditions, or other entanglements, so this should be easy to program.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of items which are or aren't -1, in proper Perl syntax, like so:

./ch-2.pl '([5,17,-1,42,-1,86,-1,-1,-1,-1],[8,"dog",-1,36,-1,-1,-1,-1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   sub last_visitor ($aref) {
      my @ints = @$aref;
      my @seen;
      my @ans;
      my $x = -1;
      for my $i (0..$#ints) {
         if ('-1' eq $ints[$i]) {
            ++$x;
            if ($x < scalar(@seen)) {
               push @ans, $seen[$x]}
            else {
               push @ans, -1}}
         else {
            $x = -1;
            unshift @seen, $ints[$i];
         }
      }
      @ans}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Input:                    Expected output:
   [5, -1, -1],              # (5, -1)
   [3, 7, -1, -1, -1],       # (7, 3, -1)
   [2, -1, 4, -1, -1],       # (2, 4, 2)
   [10, 20, -1, 30, -1, -1], # (20, 30, 20)
   [-1, -1, 5, -1],          # (-1, -1, 5)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my @lv = last_visitor($aref);
   say "Last Visitors: (@lv)";
}
