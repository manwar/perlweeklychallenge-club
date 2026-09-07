#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 385-2,
written by Robbie Hatley on Sun Aug 09, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 385-2: Outermost Parentheses
Submitted by: Mohammad Sajid Anwar
You are given a valid parentheses string. Write a script to
return the string after removing the outermost parentheses of
every primitive string in the primitive decomposition of the
given string.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of keeping track of parenthetical depth in an integer variable.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
single-quoted strings as arguments. The strings should be "valid parenthetical strings", that is, strings
where parenthetical depth is everywhere-non-negative and ends with 0. For example:

./ch-2.pl '(Frank)' '((Bob))' '(Susan((Ellen)(Cynthia)))'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # Strip the outermost parentheses from a string:
   sub strip ( $s ) {
      # Initialize a parenthetical-depth counter:
      my $p=0;
      # Traverse the string:
      for ( my $i = 0 ; $i < length $s ; ++$i ) {
         # Get current character:
         my $c = substr $s, $i, 1;
         if ( '(' eq $c ) {
            ++$p;
            if ( 1 == $p ) {
               substr $s, $i, 1, '';
               --$i;
            }
         }
         elsif ( ')' eq $c ) {
            --$p;
            if ( 0 == $p ) {
               substr $s, $i, 1, '';
               --$i;
            }
         }
      }
      # Return stripped string:
      return $s;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   # Example 1 input:
   '()()()',
   # Output: ''

   # Example 2 input:
   '(((())))',
   # Output: '((()))'

   # Example 3 input:
   '(()())(())',
   # Output: '()()()'

   # Example 4 input:
   '()((()))()',
   # Output: '(())'

   # Example 5 input:
   '(()(()))(()())',
   # Output: '()(())()()'
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say "String = $string";
   my $stripped = strip $string;
   say "Stripped = $stripped";
}
