#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 255-1.
Written by Robbie Hatley on Mon Feb 05, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 255-1: Odd Character
Submitted by: Mohammad Sajid Anwar

You are given two strings, $s and $t. The string $t is generated
using the shuffled characters of the string $s with an
additional character. Write a script to find the additional
character in the string $t.

Example 1:
Input: $s = "Perl" $t = "Preel"
Output: "e"

Example 2:
Input: $s = "Weekly" $t = "Weeakly"
Output: "a"

Example 3:
Input: $s = "Box" $t = "Boxy"
Output: "y"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Since this problem speaks of "characters" instead of "letters", I'll consider "a" and "A" to be different
"characters", and use a case-sensitive approach. I'll attack this problem by writing a sub which first splits
$s and $t into arrays @s and @t of single characters, then for each character of @s, if that character exists
in @t, splices-out the first occurrence only of that character from @t, then returns @t, which should now
consist of all "additional" characters (if any) which are in $t but not $s. Note that this approach doesn't
care if any of the characters of $s are actually in $t; if given $s="migrant" and $t="buck", the sub will
return ('b','u','c','k') because all of those letters were "added" to "migrant". (The fact that the letters
('m','i','g','r','a','n','t') were also REMOVED is irrelevant and hence ignored.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, apostrophes escaped as '"'"',
in proper Perl syntax, like this:
./ch-1.pl '(["trash", "trashy"], ["garbanzo", "gargoyle"]), ["van", "cavern"]'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub added_characters ($s, $t) {
   my @s = split //, $s;
   my @t = split //, $t;
   for my $char (@s) {
      for ( my $i = 0 ; $i <= $#t ; ++$i ) {
         if ( $char eq $t[$i] ) {
            splice @t, $i, 1;
            last;
         }
      }
   }
   return @t;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @pairs = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["Perl", "Preel"],
   # Expected Output: "e"

   # Example 2 Input:
   ["Weekly", "Weeakly"],
   # Expected Output: "a"

   # Example 3 Input:
   ["Box", "Boxy"],
   # Expected Output: "y"
);

# Main loop:
for my $pair (@pairs) {
   say '';
   my $s = $pair->[0];
   my $t = $pair->[1];
   my @added = added_characters($s, $t);
   say "\$s = \"$s\"";
   say "\$t = \"$t\"";
   say 'Added character(s) = ', join(', ', map {"\"$_\""} @added);
}
