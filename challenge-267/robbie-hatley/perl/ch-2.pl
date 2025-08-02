#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 267-2,
written by Robbie Hatley on Mon Apr 29, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 267-2: Line Counts
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, and a 26-items array @widths containing the width (in pixels) of each character
from a to z. Write a script to find out the number of lines and the width of the last line needed to display
the given string, assuming you can only fit 100 width units on a line.

Example 1 inputs:
   $str = "abcdefghijklmnopqrstuvwxyz"
   @widths = (10,10,10,10,10,10,10,10,10,10,
              10,10,10,10,10,10,10,10,10,10,
              10,10,10,10,10,10)
Expected output: (3, 60)
Line 1: abcdefghij (100 pixels)
Line 2: klmnopqrst (100 pixels)
Line 3: uvwxyz (60 pixels)

Example 2 inputs:
   $str = "bbbcccdddaaa"
   @widths = ( 4,10,10,10,10,10,10,10,10,10,
              10,10,10,10,10,10,10,10,10,10,
              10,10,10,10,10,10)
Expected output: (2, 4)
Line 1: bbbcccdddaa (98 pixels)
Line 2: a (4 pixels)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I think I'll first store the 26 widths in a hash keyed by letter, then fill up lines in an array until I'm
out of characters, then return the scalar of that array (line count) and the length of the last element
(last-line length).


--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a double-quoted string of lower-case
English letters followed by an array of 26 positive integers, in proper Perl syntax, like so:
./ch-2.pl '(["dlsnvkgueitasashdfirstpqwert",[1,23,17,4,7,2,8,20,5,3,1,23,17,4,7,2,8,20,5,3,5,2,4,3,1,7]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'sum0';
   use List::SomeUtils 'mesh';
   # Is a given scalar a string of lower-case English letters?
   sub is_az_string ($x) {
      # We're only interested in non-empty, non-huge strings consisting
      # purely of lower-case English letters abcdefghijklmnopqrstuvwxyz:
      $x !~ m/^[a-z]{1,10000}$/ and return 0;
      # If we get to here, $x passes all tests so return 1:
      return 1;
   }
   # Is a given scalar a positive integer?
   sub is_posint ($x) {
      # We're only interested in positive integers:
      $x !~ m/^[1-9]\d*$/ and return 0;
      # If we get to here, $x passes all tests so return 1:
      return 1;
   }
   # Is a given array a list of 26 positive integers?
   sub are_26_posints (@widths) {
      return 0 if 26 != scalar(@widths);
      for my $width (@widths) {return 0 if !is_posint($width);}
      return 1;
   }
   # Return count of lines, width of last line, and lines:
   sub lines ($str, @widths) {
      return (0,0) if !is_az_string($str);
      return (0,0) if !are_26_posints(@widths);
      my @letters = 'a'..'z';
      my %w = mesh @letters, @widths;
      my @lines ;
      my ($line, $width, $next, $wext);
      while ($str) {
         ($line, $width, $next, $wext) = ('',0,'',0);
         while ($str && $width + ($wext = $w{$next = substr($str, 0, 1)}) <= 100) {
            $line  .= $next;
            $width += $wext;
            substr($str, 0, 1, '');
         }
         push @lines, $line;
      }
      return (scalar(@lines), $width, @lines);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 inputs:
   [
      "abcdefghijklmnopqrstuvwxyz",
      [10,10,10,10,10,10,10,10,10,10,
       10,10,10,10,10,10,10,10,10,10,
       10,10,10,10,10,10],
   ],
   # Expected output: (3, 60)

   # Example 2 inputs:
   [
      "bbbcccdddaaa",
      [ 4,10,10,10,10,10,10,10,10,10,
       10,10,10,10,10,10,10,10,10,10,
       10,10,10,10,10,10],
   ],
   # Expected output: (2, 4)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my $str = $aref->[0];
   my $wid = $aref->[1];
   my ($count, $width, @lines)  = lines($str, @$wid);
   say "String = $str";
   say "Widths = @$wid";
   say 'Lines:';
   say for @lines;
   say "Line count = $count";
   say "Last width = $width";
}
