#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 368-1,
written by Robbie Hatley on Mon Apr 06, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 368-1: Make it Bigger
Submitted by: Mohammad Sajid Anwar
You are given a given a string number and a character digit.
Write a script to remove exactly one occurrence of the given
character digit from the given string number, resulting in
the number being maximised.

Example #1:
Input: $str = "15456", $char = "5"
Output: "1546"
Removing the second "5" is better because the digit following
it (6) is greater than 5. In the first case, 5 was followed by 4
(a decrease), which makes the resulting number smaller.

Example #2:
Input: $str = "7332", $char = "3"
Output: "732"

Example #3:
Input: $str = "2231", $char = "2"
Output: "231"
Removing either "2" results in the same string here. By removing
a "2", we allow the "3" to move up into a higher decimal place.

Example #4:
Input: $str = "543251", $char = "5"
Output: "54321"
If we remove the first "5", the number starts with 4. If we
remove the second "5", the number still starts with 5. Keeping
the largest possible digit in the highest place value is almost
always the priority.

Example #5:
Input: $str = "1921", $char = "1"
Output: "921"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use the "try it and see" method: try each possible removal and see which yields
the greatest number.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a double-quoted positive-integer string
followed by a double-quoted single-digit string, in proper Perl syntax, like so:

./ch-1.pl '(["285240", "2"],["13531", "3"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::SomeUtils qw( indexes );

   # What is the maximum positive integer we can make by
   # removing 1 copy of $c from $s?
   sub max_pos_int ( $s, $c ) {
      my @indices = indexes { $_ eq $c } split //, $s;
      !@indices and return $s;
      my $max = substr($s, 0, $indices[0]).substr($s, $indices[0]+1);
      for ( my $i = 1 ; $i <= $#indices ; ++$i ) {
         my $tmp = substr($s, 0, $indices[$i]).substr($s, $indices[$i]+1);
         if ($tmp-0 > $max-0) {$max = $tmp}
      }
      return $max
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [  "15456", "5" ], # "1546"
   [   "7332", "3" ], # "732"
   [   "2231", "2" ], # "231"
   [ "543251", "5" ], # "54321"
   [   "1921", "1" ], # "921"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $s = $aref->[0];
   my $c = $aref->[1];
   say "String = \"$s\"  Digit = \"$c\"";
   my $m = max_pos_int($s, $c);
   say "Maximum positive integer = \"$m\"";
}
