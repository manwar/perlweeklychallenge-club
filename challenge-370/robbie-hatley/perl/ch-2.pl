#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 370-2,
written by Robbie Hatley on Fri Apr 24, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 370-2: Scramble String
Submitted by: Roger Bell_West
You are given two strings A and B of the same length. Write a
script to return true if string B is a "scramble" of string A
otherwise return false. String B is a "scramble" of string A
if A can be transformed into B by a single (recursive) scramble
operation. A scramble operation is:
- If string consists of only one character, return string.
- Divide the string X into two non-empty parts.
- Optionally, exchange the order of those parts.
- Optionally, scramble each of those parts.
- Concatenate the scrambled parts to return a single string.

Example #1:
Input: $str1 = "abc", $str2 = "acb"
Output: true
"abc"
split: ["a", "bc"]
split: ["a", ["b", "c"]]
swap: ["a", ["c", "b"]]
concatenate: "acb"

Example #2:
Input: $str1 = "abcd", $str2 = "cdba"
Output: true
"abcd"
split: ["ab", "cd"]
swap: ["cd", "ab"]
split: ["cd", ["a", "b"]]
swap: ["cd", ["b", "a"]]
concatenate: "cdba"

Example #3:
Input: $str1 = "hello", $str2 = "hiiii"
Output: false
A fundamental rule of scrambled strings is that they must be
anagrams.

Example #4:
Input: $str1 = "ateer", $str2 = "eater"
Output: true
"ateer"
split: ["ate", "er"]
split: [["at", "e"], "er"]
swap: [["e", "at"], "er"]
concatenate: "eater"

Example #5:
Input: $str1 = "abcd", $str2 = "bdac"
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I know there are clever ways of solving this, but I'm not capable of wrapping my head around them, so I'll use
a simpler way (albeit with higher Big-O Complexity): I'll make an array of all "scrambles" of $str1 and return
true iff $str2 is in that array. With that in mind, I'll make these two subroutines:

sub scrambles   ( $s      ); # What are all the scrambles of a given string?
sub is_scramble ( $s , $t ); # Is a given second string a scramble of a given first string?

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["fred", "dref"],["fred", "rdef"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use List::Util 'any';

   # What are all of the scrambles of a given string?
   sub scrambles ( $s ) {
      my @scrambles = ();
      my $n = length($s);
      if ( 1 == $n ) {
         push @scrambles, $s}
      else {
         # We have $n-1 choices of where to divide $s:
         for ( my $i = 0 ; $i <= $n-2 ; ++$i ) {
            # Split the string into two pieces:
            my $L = substr($s, 0, $i-(-1)); my $R = substr($s, $i+1, ($n-1)-$i);
            # We have 8 possibilities here: 2 choices of whether to swap sides,
            # and for each of those 2 choices, 4 choices of scramble pattern:
            # LN.RN, LN.RY, LY.RN, LY.RY, RN.LN, RN.LY, RY.LN, RY.LY
            push @scrambles, $L.$R;                     # LN.RN
            push @scrambles, $R.$L;                     # RN.LN
            push @scrambles, map {$L.$_} scrambles($R); # LN.RY
            push @scrambles, map {$_.$L} scrambles($R); # RY.LN
            push @scrambles, map {$_.$R} scrambles($L); # LY.RN
            push @scrambles, map {$R.$_} scrambles($L); # RN.LY
            for my $LS (scrambles($L)) {
               for my $RS (scrambles($R)) {
                  push @scrambles, $LS.$RS;             # LY.RY
                  push @scrambles, $RS.$LS}}}}          # RY.LY
      return @scrambles}

   # Is a given second string a scramble of a given first string?
   sub is_scramble ( $s , $t ) {
      return any {$t eq $_} scrambles $s}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   ["abc", "acb"],
   # Expected output: true

   # Example #2 input:
   ["abcd", "cdba"],
   # Expected output: true

   # Example #3 input:
   ["hello", "hiiii"],
   # Expected output: false

   # Example #4 input:
   ["ateer", "eater"],
   # Expected output: true

   # Example #5 input:
   ["abcd", "bdac"],
   # Expected output: false
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $s1 = $aref->[0];
   my $s2 = $aref->[1];
   say "Strings: \"$s1\", \"$s2\"";
   print "Second string a scramble of first? ";
   my $is = is_scramble($s1, $s2);
   say $is ? "True." : "False.";
}
