#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 369-2,
written by Robbie Hatley on Tue Apr 14, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 369-2: Group Division
Submitted by: Mohammad Sajid Anwar
You are given a string, group size and filler character. Write a
script to divide the string into groups of given size. In the
last group if the string doesn’t have enough characters
remaining fill with the given filler character.

Example 1
Input: $str = "RakuPerl", $size = 4, $filler = "*"
Output: ("Raku", "Perl")

Example 2
Input: $str = "Python", $size = 5, $filler = "0"
Output: ("Pytho", "n0000")

Example 3
Input: $str = "12345", $size = 3, $filler = "x"
Output: ("123", "45x")

Example 4
Input: $str = "HelloWorld", $size = 3, $filler = "_"
Output: ("Hel", "loW", "orl", "d__")

Example 5
Input: $str = "AI", $size = 5, $filler = "!"
Output: "AI!!!"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Chop and fill. The replacement version of Perl's "substr" function will be very useful here.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a double-quoted string, a small positive
integer, and a double-quoted fill character, in proper Perl syntax, like so:

./ch-2.pl '(["pseudopseudohypoparathyroidism", 4, "~"],["Floccinaucinihilipilification", 5, "#"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Divide a given string into groups of a given size
   # And right-fill final group with a given filler:
   sub divide ( $str , $siz , $fil ) {
      my @groups = ();
      while ( length($str) > 0 ) {
         push @groups, substr($str, 0, $siz, '');
      }
      my $ll = length $groups[-1];
      if ($ll < $siz) {
         $groups[-1] .= $fil x ($siz - $ll);
      }
      return @groups;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["RakuPerl", 4, "*"],
   # Output: ("Raku", "Perl")

   # Example 2 Input:
   ["Python", 5, "0"],
   # Output: ("Pytho", "n0000")

   # Example 3 Input:
   ["12345", 3, "x"],
   # Output: ("123", "45x")

   # Example 4 Input:
   ["HelloWorld", 3, "_"],
   # Output: ("Hel", "loW", "orl", "d__")

   # Example 5 Input:
   ["AI", 5, "!"],
   # Output: "AI!!!"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $str = $aref->[0];
   my $siz = $aref->[1];
   my $fil = $aref->[2];
   say "string = \"$str\", size = $siz, filler = \"$fil\"";
   my @groups = divide($str, $siz, $fil);
   my $display = '(' . join(', ', map {'"'.$_.'"'} @groups) . ')';
   say "groups = $display";
}
