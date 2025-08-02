#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 265-2,
written by Robbie Hatley on Mon Apr 15, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 265-2: Completing Word
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, containing alphnumeric characters,
and array of strings, @str (alphabetic characters only). Write
a script to find the shortest completing word. If none found
return empty string. A "completing word" is a word that contains
all the letters in the given string, ignoring space and number.
If a letter appeared more than once in the given string then it
must appear the same number or more in the word.

Example 1:
Input: $str = 'aBc 11c'
       @str = ('accbbb', 'abc', 'abbc')
Output: 'accbbb'
The given string contains following, ignoring case and number:
a 1 times
b 1 times
c 2 times
The only string in the given array that satisfies the condition
is 'accbbb'.

Example 2:
Input: $str = 'Da2 abc'
       @str = ('abcm', 'baacd', 'abaadc')
Output: 'baacd'
The given string contains following, ignoring case and number:
a 2 times
b 1 times
c 1 times
d 1 times
There are 2 strings that satisfies the condition:
'baacd' and 'abaadc'. Shortest of the two is 'baacd'

Example 3:
Input: $str = 'JB 007'
       @str = ('jj', 'bb', 'bjb')
Output: 'bjb'
The given string contains following, ignoring case and number:
j 1 times
b 1 times
The only string that satisfies the condition is 'bjb'.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I solve this problem by making a list of all words (if any) from @str which contain at least as many of each
letter of $str as $str does. If that list has words, I return the shortest; else I return an empty string.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '(["jE38 37# b7", "Jen", "Jeff", "Jeb"],["黑94 7茶4 358", "Robbie", "黑黑茶", "Suresh", "黑茶"])'
The first element of each inner array will be construed as "$str" and the remainder as "@str" as defined in
the problem description.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
no warnings 'uninitialized';
use List::SomeUtils 'all';
sub complete ($string, @array) {
   # Make a hash of abundances of fold-cased letters from string:
   my @str_chars = map {fc} grep {/\pL/} split //, $string;
   my %str_ab;
   foreach my $char (@str_chars) {
      ++$str_ab{$char};
   }

   # Make a list of words (if any) which contain at least as many of each letter of $string as $string does:
   my @words;
   foreach my $element (@array) {
      # Make a hash of abundances of fold-cased letters from array element:
      my @ele_chars = map {fc} grep {/\pL/} split //, $element;
      my %ele_ab;
      foreach my $char (@ele_chars) {
         ++$ele_ab{$char};
      }
      # If this element contains at least as many of each letter of $string as $string does,
      # then push this element onto our list of "completing words":
      if (all {$ele_ab{$_} >= $str_ab{$_}} @str_chars) {
         push @words, $element;
      }
   }

   # If we have words, return shortest; else return empty string:
   if (scalar(@words) > 0) {
      my @sorted = sort {length($a)<=>length($b)} @words;
      return shift @sorted;
   }
   else {
      return '';
   }
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["aBc 11c", "accbbb", "abc", "abbc"],
   # Expected Output: "accbbb"

   # Example 2 Input:
   ["Da2 abc", "abcm", "baacd", "abaadc"],
   # Expected Output: "baacd"

   # Example 3 Input:
   ["JB 007", "jj", "bb", "bjb"],
   # Expected Output: "bjb"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   my @array  = @$aref;
   my $string = shift @array;
   my $word   = complete($string, @array);
   say '';
   say "String = \"$string\"";
   say 'Array  = (', join(', ', @array), ')';
   length($word) > 0 and say "Completing word = $word"
   or say 'No completing word was found.';
}
