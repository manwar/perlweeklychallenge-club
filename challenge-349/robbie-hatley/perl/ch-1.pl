#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge #349-1,
written by Robbie Hatley on Wed Nov 26, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 349-1: Power String
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script to return the power of
the given string. The power of the string is the maximum length
of a non-empty substring that contains only one unique character.

Example #1:
Input: $str = "textbook"
Output: 2
Breakdown: "t", "e", "x", "b", "oo", "k"
The longest substring with one unique character is "oo".

Example #2:
Input: $str = "aaaaa"
Output: 5

Example #3:
Input: $str = "hoorayyy"
Output: 3
Breakdown: "h", "oo", "r", "a", "yyy"
The longest substring with one unique character is "yyy".

Example #4:
Input: $str = "x"
Output: 1

Example #5:
Input: $str = "aabcccddeeffffghijjk"
Output: 4
Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i",
           "jj", "k"
The longest substring with one unique character is "ffff".

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The use of the word "unique" is a bit ambiguous here. Depending on how that's defined, the "power" of the
string "sjfhrrsiggghhhh" would be 3 if "hhhh" is rejected as "not being unique" seeing as how "h" has been
previously seen. But if "unique" means "within one substring", then the "power" is 4. I'll assume the
latter interpretation, as the examples allow either. Using that interpretation, this is just a matter of
counting repeats in a variable $r and keeping track of "maximum repeats seen so far" in a variable $max.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("rat", "book", "thinnngamajig","LOOOOOUD!!!","Oooooooh, myyyyyyy!!!")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return length of longest substring of identical characters:
   sub longest ( $s ) {
      my @chars = split //, $s; my $r = 0; my $max = 0;
      for my $idx ( 0..$#chars ) {
         if ( 0 == $idx || $chars[$idx] eq $chars[$idx-1] ) {$r += 1}
         else {$r = 1}
         if ( $r > $max ) {$max = $r}}
      $max}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("textbook","aaaaa","hoorayyy","x","aabcccddeeffffghijjk");
#                   Expected outputs :        2     5            3     1             4
# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "String = $s";
   my $l = longest($s);
   say "Longest = $l"
}
