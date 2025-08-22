#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 335-1,
written by Robbie Hatley on Mon Aug 18, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 335-1: Common Characters
Submitted by: Mohammad Sajid Anwar
You are given an array of words. Write a script to return all
characters that is in every word in the given array including
duplicates.

Example #1:
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example #2:
Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

Example #3:
Input: @words = ("hello", "world", "pole")
Output: ("l", "o")

Example #4:
Input: @words = ("abc", "def", "ghi")
Output: ()

Example #5:
Input: @words = ("aab", "aac", "aaa")
Output: ("a", "a")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll make a hash %least to keep track of "least common copies" of each character which
is common to all elements of the input array, then for each key $key of %least I'll return $least{$key} copies
of '"'.$key.'"'.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '(["rat", "bat", "cat"],["sooth", "moot", "looters"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'uniq';

   # List common characters including duplicates:
   sub common_characters ($aref) {
      # Get list of characters in @$aref:
      my @characters;
      for my $word (@$aref) {
         my @letters = split //, $word;
         for my $letter (@letters) {
            push @characters, $letter}}
      # How many characters did we find?
      my $n = scalar @characters;
      # Get list of UNIQUE characters in @$aref:
      my @unique = uniq sort @characters;
      # Make a hash of least copies of common characters:
      my %least;
      # Check each unique character; if it's common between
      # all words in @$aref, record least copies:
      for my $character (@unique) {
         # Each word has < $n copies of any one character:
         my $least = $n;
         # For each word in @$aref, how many copies of
         # $character does it have in it?
         for my $word (@$aref) {
            my @matches = $word =~ m/$character/g;
            my $copies = scalar @matches;
            if ($copies < $least) {$least = $copies}
            # Skip non-common characters:
            last if 0 == $least}
         # Skip non-common characters:
         next if 0 == $least;
         # Record least copies of common characters in %least:
         $least{$character} = $least}
      # Make an array to hold our output:
      my @output;
      # For each common character, push "least copies"
      # copies of that character, double-quoted, onto @output:
      for my $key (sort keys %least) {
         push @output, ('"'.$key.'"')x$least{$key}}
      # Finally, return our output:
      @output}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   ["bella", "label", "roller"],
   # Expected output: ("e", "l", "l")

   # Example #2 input:
   ["cool", "lock", "cook"],
   # Expected output: ("c", "o")

   # Example #3 input:
   ["hello", "world", "pole"],
   # Expected output: ("l", "o")

   # Example #4 input:
   ["abc", "def", "ghi"],
   # Expected output: ()

   # Example #5 input:
   ["aab", "aac", "aaa"],
   # Expected output: ("a", "a")
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Words = (@$aref)";
   my @cc = common_characters($aref);
   say "Common characters = (@cc)";
}
