#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 275-2,
written by Robbie Hatley on Mon Jun 24, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 275-2: Replace Digits
Submitted by: Mohammad Sajid Anwar
You are given an alphanumeric string, $str, where each character
is either a letter or a digit. Write a script to replace each
digit in the given string with the value of the previous letter
plus (digit) places.

Example 1:
Input: $str = 'a1c1e1'
Ouput: 'abcdef'
shift('a', 1) => 'b'
shift('c', 1) => 'd'
shift('e', 1) => 'f'

Example 2:
Input: $str = 'a1b2c3d4'
Output: 'abbdcfdh'
shift('a', 1) => 'b'
shift('b', 2) => 'd'
shift('c', 3) => 'f'
shift('d', 4) => 'h'

Example 3:
Input: $str = 'b2b'
Output: 'bdb'

Example 4:
Input: $str = 'a16z'
Output: 'abgz'

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I find it interesting that the examples show that "previous digit" means "nearest digit to the left in
original strinug, if any", rather than "digit immediately to the left". This causes two ambiguities:

1. What if there is NO previous letter?
2. What if we try to shift 'z' by 3?

I think I'll fix #1 by returning 'invalid_string' unless the input is well-formed (m/[a-z][a-z0-9]*/).

And I'll fix #2 by looping back to the beginning of the alphabet as in ROT13 (so that z3 is c).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings matching m/^[a-z]{1}[a-z0-9]*$/, in proper Perl syntax, like so:
./ch-2.pl '("z9a3bgq2f", "z9z1z7z2")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   sub replace_digits ($string) {
      return 'invalid_string' unless $string =~ m/[a-z][a-z0-9]*/;
      my $new = '';
      my $prev = '-';
      for my $char (split //, $string) {
         if ( $char =~ m/^[a-z]{1}$/ ) {
            $prev = $char;
            $new .= $char;
         }
         elsif ( $char =~ m/^[0-9]{1}$/ ) {
            return 'invalid_prev' unless $prev =~ m/^[a-z]{1}$/;
            my $old_ord = ord($prev);
            my $new_ord = ($old_ord - 97 + $char) % 26 + 97;
            $new .= chr $new_ord;
         }
         else {return 'invalid_char';}
      }
      $new;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   'a1c1e1',
   # Expected output = 'abcdef'

   # Example 2 input:
   'a1b2c3d4',
   # Expected output = 'abbdcfdh'

   # Example 3 input:
   'b2b',
   # Expected output = 'bdb'

   # Example 4 input:
   'a16z',
   # Expected output = 'abgz'
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say "Original string = $string";
   say 'String with digits replacecd = ', replace_digits $string;
}
