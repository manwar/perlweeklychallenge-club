#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 280-1,
written by Robbie Hatley on Mon Jul 29, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 280-1: Twice Appearance
Submitted by: Mohammad Sajid Anwar
Given a string containing lowercase English letters only, write
a script to print the first letter to appear a second time.

[Note, Robbie Hatley, 2024-07-29: The original version said
"first letter that appears twice", but the examples contradict
that, so I edited it to read "a second time" instead of
"twice", in order to jibe with the examples. For example, in
"acbddbca" the first letter to appear twice is "a", but the
first letter to appear a second time is "d". The difference is
that "twice" is not positional, but "second time" IS positional
left-to-right (because that's the direction English is read in).]

Example 1:
Input:  "acbddbca"
Output: "d" (not a, because d "appears a second time" before a).

Example 2:
Input:  "abccd"
Output: "c" (c is only letter to appear a second time)

Example 3:
Input:  "abcdabbb"
Output: "a" (not b, because a "appears a second time" before b).

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll make a hash of letter abundances. The first letter to reach an abundance greater
than 1 will be returned, else the Unicode replacement character if no letter appears a second time.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '("making", "caterer", "isomorphism")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   sub second ($x) {
      my %hash;
      my $char;
      for my $idx (0..length($x)-1) {
         $char = substr($x,$idx,1);
         ++$hash{$char};
         if (2 == $hash{$char}){
            return $char;
         }
      }
      return "\x{FFFD}";
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   "acbddbca",
   "abccd",
   "abcdabbb",
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $x (@strings) {
   my $second = second($x);
   say '';
   say "String = $x";
   say "First character to appear a second time = $second";
}
