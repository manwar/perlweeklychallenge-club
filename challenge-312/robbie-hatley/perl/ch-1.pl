#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 312-1,
written by Robbie Hatley on Mon Mar 10, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 312-1: Minimum Time
Submitted by: Mohammad Sajid Anwar
You are given a typewriter with lowercase english letters a to z
arranged in a circle. Typing a character takes 1 second. Moving
the pointer one character clockwise or anti-clockwise also takes
1 second. The pointer initially points to a. Write a script to
return minimum time it takes to print a given string.

Example #1:
Input: $str = "abc"
Output: 5
The pointer is at 'a' initially.
1 sec - type the letter 'a'
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer clockwise to 'c'
1 sec - type the letter 'c'

Example 2
Input: $str = "bza"
Output: 7
The pointer is at 'a' initially.
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer anti-clockwise to 'a'
1 sec - move pointer anti-clockwise to 'z'
1 sec - type the letter 'z'
1 sec - move pointer clockwise to 'a'
1 sec - type the letter 'a'

Example 3
Input: $str = "zjpc"
Output: 34

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is essentially a modular-arithmetic problem. Let $orig be the ASCII ordinal of the current location, and
let $dest be the ASCII ordinal of the destination. Then if ($dest-$orig)%26 < 14, move pointer clockwise, else
move pointer counterclockwise. That will give minimum distance traveled, and hence minimum time.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more arguments which must
be single-quoted strings consisting only of lower-case English letters ([abcdefghijklmnopqrstuvwxyz]).
For example:
./ch-1.pl 'kumquat' 'tangerine' 'persimmon' 'durian'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # does a given scalar consist purely of letters a-z?
   sub is_lower_case_english ($word) {
      $word =~ m/^[a-z]+$/;
   }

   # What is the minimum time to type a given word?
   sub minimum_time ($word) {
      my $mt = 0;       # minimum time
      my $pc = ord 'a'; # previous character's ord
      for my $idx (0..length($word)-1) {
         # Get current character's ord:
         my $cc = ord substr $word, $idx, 1;
         # Get "right" (clockwise) move time:
         my $r = ($cc-$pc)%26;
         # Get shortest move time:
         my $s = ($r < 14) ? $r : 26-$r;
         # Add shortest move time, plus 1 for typing, to $mt:
         $mt += ($s+1);
         # Set previous character to current character:
         $pc = $cc;
      }
      return $mt;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @words = @ARGV ? @ARGV : ('abc', 'bza', 'zjpc');
#                 Expected outputs :    5      7      34

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $word (@words) {
   say '';
   say "Word = $word";
   if (!is_lower_case_english($word)) {
      say "Error: not a lower-case-English word.";
      say "Moving on to next word.";
      next;
   }
   my $mt = minimum_time($word);
   say "Minimum time to type that word is $mt"
}
