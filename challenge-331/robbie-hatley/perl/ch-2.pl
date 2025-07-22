#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 331-2,
written by Robbie Hatley on Mon Jul 21, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 331-2: Buddy Strings
Submitted by Mohammad Sajid Anwar.
Edited by Robbie Hatley for family-friendliness, grammar,
and clarification of examples.

You are given two strings, source and target. Write a script to
find out if the given strings are Buddy Strings. If swapping of
two letters in one string makes it same as the other string,
then they are "Buddy Strings".

Example #1:
Input: $source = "fram"
       $target = "farm"
Output: true
(Swapping 'a' and 'r' makes them buddy strings.)

Example #2:
Input: $source = "love"
       $target = "love"
Output: false
(Because the strings are identical but have no letters
in-common, any swap leaves the two strings different.)

Example #3:
Input: $source = "fodo"
       $target = "food"
Output: true
(Because the strings are different with exactly two
differences which are mirror images of each other,
swapping the two "different" letters in one string
makes it the same as the other string.)

Example #4:
Input: $source = "feed"
       $target = "feed"
Output: true
(Because the strings are identical, normally any
swapping of letters in one string would make it
different from the other; but because duplicate
letters exist, we can swap THOSE, resulting in
the two strings STILL being identical.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll write a sub that determines the buddy-ness of a pair of strings by running these checks:
1. If the lengths of the two strings are not equal, the strings aren't buddies.
2. If the strings are identical, they're buddies if-and-only-if they contain duplicate characters.
3. If the strings are same-size-but-different:
   a. If number of indices for which the characters are unequal is not 2, the strings aren't buddies.
   b. If the second pair of unequal characters is not the reverse of the first, the strings aren't buddies.
   c. Otherwise, the strings are buddies.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["granite", "gabro"], ["granite", "gnarite"], ["bark", "fork"], ["dog", "dog"], ["rook", "rook"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'uniq';
   # Are a pair of strings good buddies?
   sub buddies ($s1, $s2) {
      # Get the lengths of the two strings:
      my $n1 = length($s1); my $n2 = length($s2);
      # If the lengths are unequal, the strings aren't buddies:
      return 'False.' if $n1 != $n2;
      # If the two strings are identical, then they are buddies
      # if-and-only-if they contain duplicate characters:
      if ( $s1 eq $s2 ) {
         my @sorted = sort {$a cmp $b} split //, $s1;
         my @unique = uniq @sorted;
         return 'True.' if scalar(@unique) < scalar(@sorted);
         return 'False.'}
      # Else if the two strings are different, the number of
      # differences must be 2, and the second character pair
      # must be the reverse of the first character pair:
      else {
         my @ue = (); # List of unequal character pairs.
         for my $idx (0..$n1-1) {
            my $c1 = substr($s1, $idx, 1);
            my $c2 = substr($s2, $idx, 1);
            next if $c1 eq $c2;
            push @ue, $c1.$c2}
         return 'False.' if 2 != scalar @ue;
         return 'False.' if $ue[1] ne scalar reverse $ue[0];
         return 'True.'}}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : (["fram", "farm"], ["love", "love"], ["feed", "feed"]);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $s1 = $aref->[0];
   my $s2 = $aref->[1];
   my $b = buddies($s1, $s2);
   say "String 1 = \"$s1\"";
   say "String 2 = \"$s2\"";
   say "Strings are buddies? $b";
}
