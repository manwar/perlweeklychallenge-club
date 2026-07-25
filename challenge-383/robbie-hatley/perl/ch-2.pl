#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 383-2,
written by Robbie Hatley on Sat Jul 25, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 383-2: Nearest RGB
Submitted by: Mohammad Sajid Anwar
You are given a 6-digit hex color. Write a script to round the RGB channels to the nearest "web-safe value"
and return the nearest RGB color. "web-safe" channel values are:
   0x00 (  0)
   0x33 ( 51)
   0x66 (102)
   0x99 (153)
   0xCC (204)
   0xFF (255)

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I wrote two subroutines: "snap", which snaps any real number to the closest web-safe
channel value; and "safe", which gives the web-safe color number for each original color number (by calling
"snap" once for each of the three channel values then combining and returning the result).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted 6-digit hex color strings prefaced with "#", in proper Perl syntax,
like so:

./ch-2.pl '("#3A7BAE", "#178CFD", "#1313FF")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # Snap a number to the nearest of
   # 0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF:
   sub snap ( $x ) {
      my $out = 0x00;
      my $min = 50_000_000 + abs $x;
      if (abs($x - 0x00) < $min) {$min = abs($x - 0x00); $out = 0x00;}
      if (abs($x - 0x33) < $min) {$min = abs($x - 0x33); $out = 0x33;}
      if (abs($x - 0x66) < $min) {$min = abs($x - 0x66); $out = 0x66;}
      if (abs($x - 0x99) < $min) {$min = abs($x - 0x99); $out = 0x99;}
      if (abs($x - 0xCC) < $min) {$min = abs($x - 0xCC); $out = 0xCC;}
      if (abs($x - 0xFF) < $min) {$min = abs($x - 0xFF); $out = 0xFF;}
      return $out;
   }

   # Find the nearest web-safe color for a given color:
   sub safe ( $x ) {
      # All malformed colors fade to black:
      return 0 if $x < 0x000000 || $x > 0xFFFFFF;
      # Get original RGB channels:
      my $ro = ($x & 0xFF0000) >> 16;
      my $go = ($x & 0x00FF00) >>  8;
      my $bo = ($x & 0x0000FF) >>  0;
      # Get the "snapped" RGB channels:
      my $rs = snap($ro);
      my $gs = snap($go);
      my $bs = snap($bo);
      # Return the combined number:
      return ( ($rs << 16) + ($gs <<  8) + ($bs <<  0) );
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @colors = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "#F4B2D1",
   # Expected output: "#FF99CC"

   # Example 2 input:
   "#15E6E5",
   # Expected output: "#00FFCC"

   # Example 3 input:
   "#191A65",
   # Expected output: "#003366"

   # Example 4 input:
   "#2D5A1B",
   # Expected output: "#336633"

   # Example 5 input:
   "#00FF66",
   # Expected output: "#00FF66"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $color (@colors) {
   say '';
   # Convert "#" nomenclature to "0x" nomenclature:
   $color =~ s/#/0x/;
   # Re-interpret from string to numeric:
   $color = eval($color);
   printf("Original color = %06X\n", $color);
   my $websafe = safe($color);
   printf("Websafe  color = %06X\n", $websafe);
}
