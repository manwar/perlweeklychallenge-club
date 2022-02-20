#!/usr/bin/perl
# 
# TASK #2 - Rectangle Area
# 
# You are given coordinates bottom-left and top-right corner of two rectangles in a 2D plane.
# 
# Write a script to find the total area covered by the two rectangles.
# 
# Example 1:
# 
# 	Input: Rectangle 1 => (-1,0), (2,2)
# 	       Rectangle 2 => (0,-1), (4,4)
# 
# 	Output: 22
# 
# Example 2:
# 
# 	Input: Rectangle 1 => (-3,-1), (1,3)
# 	       Rectangle 2 => (-1,-3), (2,2)
# 
# 	Output: 25
# 
# MY NOTES: Of course the tricky bit here is when the rectangles overlap.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use List::Util qw(min max);
#use Data::Dumper;

my $debug=0;

die "Usage: rectangle-area x1,y1 x2,y2 x3,y3 x4,y4\n" unless @ARGV==4;
my( $x1, $y1 ) = split( /,/, shift );

my( $x2, $y2 ) = split( /,/, shift );
my( $x3, $y3 ) = split( /,/, shift );
my( $x4, $y4 ) = split( /,/, shift );

# make sure that x1 <= x2. y1 <= y2, x3 <= x4, y3 <= y4
($x1,$x2) = ($x2,$x1) if $x1 > $x2;
($y1,$y2) = ($y2,$y1) if $y1 > $y2;
($x3,$x4) = ($x4,$x3) if $x3 > $x4;
($y3,$y4) = ($y4,$y3) if $y3 > $y4;

my $r1area = ($x2-$x1)*($y2-$y1);
my $r2area = ($x4-$x3)*($y4-$y3);
say "r1 area: $r1area, r2 area: $r2area" if $debug;

# overlap:
my $oxd = min($x2,$x4) - max($x1,$x3);
my $oyd = min($y2,$y4) - max($y1,$y3);
my $oarea = ($oxd>0 && $oyd>0) ? $oxd * $oyd : 0;

say "overlapping area: $oarea" if $debug;

my $total = $r1area + $r2area - $oarea;

say $total;
