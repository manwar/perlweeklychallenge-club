#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 321-2,
written by Robbie Hatley on Mon May 12, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 321-2: Backspace Compare
Submitted by: Mohammad Sajid Anwar
You are given two strings containing zero or more #. Write a
script to return true if the two given strings are same by
treating # as backspace.

Example #1:
Input: $str1 = "ab#c"
       $str2 = "ad#c"
Output: true
For first string,  we remove "b" as it is followed by "#".
For second string, we remove "d" as it is followed by "#".
In the end both strings became the same.

Example #2:
Input: $str1 = "ab##"
       $str2 = "a#b#"
Output: true

Example #3:
Input: $str1 = "a#b"
       $str2 = "c"
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll solve this by simply doing what each "#" backspace character means: "erase this character, and the one to
its left (if this is not the first character)". Then compare the processed strings.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["rat#ck", "Greg####rack"],["Hadley####tley", "Hadley####thaway"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use Sys::Binmode;
   use utf8::all;

   # Treat each octothorpe in a string as a backspace command:
   sub backspace ($s) {
      for ( my $i = 0 ; $i < length($s) ; ++$i ) { # For each character in string:
         if ('#' eq substr($s,$i,1)) {             # If it's a "#":
            substr($s,$i,1,'');                    # Remove "#".
            --$i;                                  # Decrement index.
            if ($i >= 0) {                         # If index is still non-negative:
               substr($s,$i,1,'');                 # Also remove the character that was to the left of the "#"
               --$i;}}}                            # and decrement the index again.
      return $s;}                                  # Return result.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["ab#c", "ad#c"], # Expected output: true
   ["ab##", "a#b#"], # Expected output: true
   ["a#b" , "c"   ], # Expected output: false
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my ($s1,$s2) = @$aref[0,1];
   my ($b1,$b2) = map {backspace($_)} ($s1,$s2);
   say "String 1 (original) = $s1";
   say "String 2 (original) = $s2";
   say "String 1 (backspcd) = $b1";
   say "String 2 (backspcd) = $b2";
   my $bc = (backspace($s1) eq backspace($s2)) ? 'true' : 'false';
   say "Backspace compare: $bc";
}
