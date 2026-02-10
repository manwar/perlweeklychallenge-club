#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 360-1,
written by Robbie Hatley on Tue Feb 10, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 360-1: Text Justifier
Submitted by: Mohammad Sajid Anwar
You are given a string and a width. Write a script to return the
string that centers the text within that width using asterisks *
as padding.

(
   # Example #1 input:
   ["Hi", 5],
   # Expected output: "*Hi**"

   # Example #2 input:
   ["Code", 10],
   # Expected output: "***Code***"

   # Example #3 input:
   ["Hello", 9],
   # Expected output: "**Hello**"

   # Example #4 input:
   ["Perl", 4],
   # Expected output: "Perl"

   # Example #5 input:
   ["A", 7],
   # Expected output: "***A***"

   # Example #6 input:
   ["", 5]
   # Expected output: "*****"
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this, just compute the left and right pad widths, then do:
$out = '*'x$lpw . $str . '*'x$rpw

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of two-element arrays, with each inner array containing a double-quoted string followed
by a positive integer, in proper Perl syntax, like so:

./ch-1.pl '(["rat", 42], ["horse", 17], ["Agamemnon", 3])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Pad a given string to a given width with "*":
   sub pad ( $str, $wid ) {           # Input string and desired width.
      my $out;                        # Output string.
      my $len = length $str;          # Length of input string.
      if ( $len < $wid ) {            # If string is shorter than desired width:
         my $tpw = $wid - $len;       # Total pad width needed.
         my $lpw = int($tpw/2);       # Left  Pad Width.
         my $rpw = $tpw - $lpw;       # Right Pad Width.
         $out='*'x$lpw.$str.'*'x$rpw; # Pad the string.
      }
      else {                          # Else if string is long enough,
         $out = $str;                 # output is same as input.
      }
      $out;                           # Return result.
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   ["Hi", 5],
   # Expected output: "*Hi**"

   # Example #2 input:
   ["Code", 10],
   # Expected output: "***Code***"

   # Example #3 input:
   ["Hello", 9],
   # Expected output: "**Hello**"

   # Example #4 input:
   ["Perl", 4],
   # Expected output: "Perl"

   # Example #5 input:
   ["A", 7],
   # Expected output: "***A***"

   # Example #6 input:
   ["", 5]
   # Expected output: "*****"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
foreach my $aref (@arrays) {
   say '';
   my $str = $$aref[0];
   my $wid = $$aref[1];
   my $out = pad($str, $wid);
   say "Original string = $str";
   say "Desired  width  = $wid";
   say "Padded   string = $out";
}
