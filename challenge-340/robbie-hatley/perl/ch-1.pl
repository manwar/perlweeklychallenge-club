#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 340-1,
written by Robbie Hatley on Tue Sep 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 340-1: Duplicate Removals
Submitted by: Mohammad Sajid Anwar
You are given a string consisting of lowercase English letters.
Write a script to return the final string after all duplicate
removals have been made. Repeat duplicate removals on the given
string until we no longer can. A duplicate removal consists of
choosing two adjacent and equal letters and removing them.

Example #1:
Input:  'abbaca'
Output: 'ca'
Step 1: Remove 'bb' => 'aaca'
Step 2: Remove 'aa' => 'ca'

Example #2:
Input:  'azxxzy'
Output: 'ay'
Step 1: Remove 'xx' => 'azzy'
Step 2: Remove 'zz' => 'ay'

Example #3:
Input:  'aaaaaaaa'
Output: ''
Step 1: Remove 'aa' => 'aaaaaa'
Step 2: Remove 'aa' => 'aaaa'
Step 3: Remove 'aa' => 'aa'
Step 4: Remove 'aa' => ''

Example #4:
Input:  'aabccba'
Output: 'a'
Step 1: Remove 'aa' => 'bccba'
Step 2: Remove 'cc' => 'bba'
Step 3: Remove 'bb' => 'a'

Example #5:
Input:  'abcddcba'
Output: ''
Step 1: Remove 'dd' => 'abccba'
Step 2: Remove 'cc' => 'abba'
Step 3: Remove 'bb' => 'aa'
Step 4: Remove 'aa' => ''

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use "substr" in a 3-part loop, double-decrementing the index after each deletion
in order to account for possible new "duplicate" relationship between previous character and new current
character.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("看的星星", "rat", "booth", "Mississippi", "lollollol")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Nix all duplicates from a string:
   sub nix_dup ($s) {
      for ( my $idx = 0 ; $idx <= length($s)-2 ; ++$idx ) {
         if ( substr($s, $idx, 1) eq substr($s, $idx+1, 1) ) {
            substr $s, $idx, 2, '';
            $idx -= 2;
            $idx = -1 if $idx < -1}}
      $s}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("abbaca", "azxxzy", "aaaaaaaa", "aabccba", "abcddcba");
#                   Expected outputs :  "ca"      "ay"      ""          "a"        ""

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   my $t = nix_dup($s);
   say "Original string = \"$s\"";
   say "Deduped  string = \"$t\""}
