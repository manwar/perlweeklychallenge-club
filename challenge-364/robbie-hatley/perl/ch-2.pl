#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge #364-2,
written by Robbie Hatley on Tue Mar 10, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task #364-2: Goal Parser
Submitted by: Mohammad Sajid Anwar
You are given a string, $str. Write a script to interpret the
given string using Goal Parser. The Goal Parser interprets “G” as
the string “G”, “()” as the string “o”, and “(al)” as the string
“al”. The interpreted strings are then concatenated in the
original order.

Example #1:
Input: $str = "G()(al)"
Output: "Goal"

Example #2:
Input: $str = "G()()()()(al)"
Output: "Gooooal"

Example #3:
Input: $str = "(al)G(al)()()"
Output: "alGaloo"

Example #4:
Input: $str = "()G()G"
Output: "oGoG"

Example #5:
Input: $str = "(al)(al)G()()"
Output: "alalGoo"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
s/\(\))/o/g; s/\(al\)/al/g;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '("rat", "c()(al)", "(G)()lfing is fun!")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Goal Parser:
   sub goal_parser ( $s ) {
      my $g = $s;
      $g =~ s/\(\)/o/g;
      $g =~ s/\(al\)/al/g;
      return $g;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0])
                    : ("G()(al)", "G()()()()(al)", "(al)G(al)()()", "()G()G", "(al)(al)G()()");
# Expected outputs  :   Goal       Gooooal          alGaloo          oGoG      alalGoo

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "Raw string = $s";
   my $p = goal_parser($s);
   say "Parsed string = $p";
}
