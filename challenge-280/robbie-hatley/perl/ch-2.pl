#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 280-2,
written by Robbie Hatley on Mon Jul 29, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 280-2: Count Asterisks
Submitted by: Mohammad Sajid Anwar
Given a string where every two consecutive vertical bars are
grouped into a pair, write a script to return the number of
asterisks, *, excluding any within each pair of vertical bars.

[Note, Robbie Hatley, 2024-07-29: The original said "between
each pair", but the examples make it clear that the intended
meaning is the opposite, "within each pair". ("Between" would
mean "NOT within any pair; outside of all pairs".)]

Example 1:
Input: "p|*e*rl|w**e|*ekly|"
Ouput: 2
(Pair 1 contains "*e*rl" and Pair 2 contains "*ekly", so those
are excluded, leaving "pw**e", which contains 2 asterisks.)

Example 2:
Input: $str = "perl"
Ouput: 0
(There are no asterisks at all, so the count is zero.)

Example 3:
Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
Ouput: 5
(Pair 1 contains "ewe", Pair 2 contains "k", and Pair 3 contains
"allenge", so those are excluded, leaving "the**l***yche", which
contains 5 asterisks.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use a finite state machine with 2 states: "count on" and "count off", denoted by
setting variable $state to 1 for on or 0 for off. $state starts in state "on" at the left end of the string,
then as we move right, $state is toggled each time we reach a "|" character. Count asterisks, starting from
zerio, only while $count is "on"; the final count is our answer.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '("I d*r*a*n*k a |c*u*p| of tea!", "She ate* seven |r*a*b*b*i*t*s|.", "I burped.")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   sub count ($x) {
      my $state = 1;
      my $count = 0;
      my $char  = "\x{FFFD}";
      for my $idx (0..length($x)-1) {
         $char = substr($x, $idx, 1);
         if ('|' eq $char) {
            $state = !$state;
         }
         elsif ('*' eq $char && $state) {
            ++$count;
         }
         else {
            ; # Do nothing.
         }
      }
      return $count;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   "p|*e*rl|w**e|*ekly|",
   "perl",
   "th|ewe|e**|k|l***ych|alleng|e",
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $x (@strings) {
   my $count = count($x);
   say '';
   say "String = $x";
   say "Number of non-excluded asterisks = $count";
}
