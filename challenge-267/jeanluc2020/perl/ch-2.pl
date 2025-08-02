#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/#TASK2
#
# Task 2: Line Counts
# ===================
#
# You are given a string, $str, and a 26-items array @widths containing the width of each character from a to z.
#
# Write a script to find out the number of lines and the width of the last line
# needed to display the given string, assuming you can only fit 100 width units
# on a line.
#
## Example 1
##
## Input: $str = "abcdefghijklmnopqrstuvwxyz"
##        @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
## Output: (3, 60)
##
## Line 1: abcdefghij (100 pixels)
## Line 2: klmnopqrst (100 pixels)
## Line 3: uvwxyz (60 pixels)
#
## Example 2
##
## Input: $str = "bbbcccdddaaa"
##        @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
## Output: (2, 4)
##
## Line 1: bbbcccdddaa (98 pixels)
## Line 2: a (4 pixels)
#
############################################################
##
## discussion
##
############################################################
#
# Split the string into its characters. For each character, check if it still fits
# into the current line. If it doesn't, reset the length of the current line to 0 and
# add the width to this new line. In the end, we will have the number of lines and
# the current length, so we just print both.

use strict;
use warnings;

line_counts( "abcdefghijklmnopqrstuvwxyz", 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
line_counts( "bbbcccdddaaa", 4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);

sub line_counts {
   my ($str, @widths) = @_;
   print "Input: \$str    = \"$str\"\n";
   print "       \@widths = (", join(",", @widths), ")\n";
   my $line_width = 100;
   my $current = 0;
   my $line_count = 0;
   foreach my $char (split //, $str) {
      my $idx = ord($char) - 97;
      if($current + $widths[$idx] > $line_width) {
         # We would have an overflow, so reset the current length to 0
         $current = 0;
      }
      if($current == 0) {
         # this is either a new line or the first one
         # add 1 to line_count in both cases, as we start
         # with 0 above.
         $line_count++;
      }
      $current += $widths[$idx];
   }
   print "Output: ($line_count, $current)\n";
}
