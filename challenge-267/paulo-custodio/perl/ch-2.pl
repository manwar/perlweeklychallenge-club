#!/usr/bin/env perl

# Challenge 267
#
# Task 2: Line Counts
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str, and a 26-items array @widths containing the
# width of each character from a to z.
#
# Write a script to find out the number of lines and the width of the last line
# needed to display the given string, assuming you can only fit 100 width units
# on a line.
# Example 1
#
# Input: $str = "abcdefghijklmnopqrstuvwxyz"
#        @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
# Output: (3, 60)
#
# Line 1: abcdefghij (100 pixels)
# Line 2: klmnopqrst (100 pixels)
# Line 3: uvwxyz (60 pixels)
#
# Example 2
#
# Input: $str = "bbbcccdddaaa"
#        @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
# Output: (2, 4)
#
# Line 1: bbbcccdddaa (98 pixels)
# Line 2: a (4 pixels)

use Modern::Perl;

my $LINE_WIDTH = 100;

my($str, @widths) = @ARGV;
say join " ", line_counts($str, @widths);

sub line_counts {
    my($str, @widths) = @_;
    my $lines = 1;
    my $col = 0;
    for my $ch (split //, $str) {
        my $width = $widths[ord($ch)-ord('a')];
        if ($col + $width > $LINE_WIDTH) {
            $lines++;
            $col = 0;
        }
        $col += $width;
    }
    return ($lines, $col);
}
