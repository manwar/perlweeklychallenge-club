#!/usr/bin/perl

# Challenge 027
#
# Task #1
# Write a script to find the intersection of two straight lines. The
# co-ordinates of the two lines should be provided as command line parameter.
# For example:
#
# The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
#
# The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
#
# The script should print the co-ordinates of point of intersection of the
# above two lines.

use Modern::Perl;

my($x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4) = @ARGV;
my $D = ($x1-$x2)*($y3-$y4)-($y1-$y2)*($x3-$x4);
my $x = (($x1*$y2-$y1*$x2)*($x3-$x4)-($x1-$x2)*($x3*$y4-$y3*$x4))/$D;
my $y = (($x1*$y2-$y1*$x2)*($y3-$y4)-($y1-$y2)*($x3*$y4-$y3*$x4))/$D;
say sprintf("%.1f %.1f", $x, $y);
