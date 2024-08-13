#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 282-1,
written by Robbie Hatley on Mon Aug 12, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 282-1: Good Integer
Submitted by: Mohammad Sajid Anwar
Write a script which, given a positive integer x with 3 or more
digits, returns the Good Integers within x (or -1 if none found),
where a "Good Integer" is a substring of x consisting of
exactly 3 identical digits (greedy match, left and right).
For example, in "2899467772", "777" is a "Good Integer"; but in
"28994677772", the string "777" is NOT a "Good Integer", even
though it appears in two places, because the substring of 7s is
4 digits long, not 3 digits.

Example 1:
Input: $int = 12344456
Output: "444"

Example 2:
Input: $int = 1233334
Output: -1 (because substring 3333 is 4 digits long, not 3)

Example 3:
Input: $int = 10020003
Output: "000"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll base the solution to this (and to 282-2) on the concept of "m//g operator in scalar context".
Specifically, in 282-1 I'll check for a single-character match followed by 1-or-more copies of itself,
then print all such matches which have length 3.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted positive integers, in proper Perl syntax, like so:
./ch-1.pl '("29554449377724888886610","12223444456663388899999")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   sub good_ints ($x) {
      my @gi = ();
      while ($x =~ m/(.)\1+/g) {
         push @gi, $& if 3 == length $&;
      }
      !@gi and push @gi, -1;
      @gi
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : ("12344456","1233334","10020003");
#                  Expected output:      444       -1          000

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $int (@ints) {
   my @gi = good_ints($int);
   say "Good Integers found within $int include " . join ', ', @gi;
}
