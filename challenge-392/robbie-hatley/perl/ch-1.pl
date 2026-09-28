#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 392-1,
written by Robbie Hatley on Sun Sep 27, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 392-1: Convert Palindrome
Submitted by: Mohammad Sajid Anwar
Write a script to convert a given string to a palindrome by
concatenating the minimum number of characters to its left.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I realized that to minimize letters added, I should look for the longest palindromic
prefix within the word, then just tack the reversed remainder to the word's left.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
string arguments. For example:

./ch-1.pl 'parapet' 'seven' 'cat' '' 'I' 'syzygy'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   $"=', ';

   # Convert a string into a palindrome by concatenating
   # the minimum number of characters to its left end:
   sub left_palindrome ( $s ) {
      # What is the longest left palindrome in the string?
      my $n = length $s;
      my $i;
      for ( $i = $n ; $i >= 0 ; --$i ) {
         my $left = substr($s, 0, $i);
         last if $left eq reverse($left);
      }
      # Now just tack the reverse of the right part onto
      # the left of the left part:
      reverse(substr($s, $i)).$s;
   }

   # Trim non-glyph characters from the front and back of a string:
   sub trim_nonglyph ( $s ) {
      $s =~ s/\A[\pZ\p{Cc}\p{Cf}]*(.*?)[\pZ\p{Cc}\p{Cf}]*\z/$1/sr;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? map {trim_nonglyph $_} @ARGV :
(
   'pinnipeds',  # sdepinnipeds
   'abcd',       # dcbabcd
   'bananas',    # sananabananas
   'dissident',  # tnedissident
   'cailliachs', # shcailliachs
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   my $lp = left_palindrome($string);
   printf("String = %-17s left palindrome = %s\n", $string , $lp);
}
