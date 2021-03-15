#!/usr/bin/perl

# Challenge 101
# 
# TASK #2 › Origin-containing Triangle
# Submitted by: Stuart Little
# You are given three points in the plane, as a list of six co-ordinates: 
# A=(x1,y1), B=(x2,y2) and C=(x3,y3).
# 
# Write a script to find out if the triangle formed by the given three 
# co-ordinates contain origin (0,0).
# 
# Print 1 if found otherwise 0.

use strict;
use warnings;
use 5.030;

my($x1,$y1,$x2,$y2,$x3,$y3) = @ARGV;
say point_in_triangle(0,0, $x1,$y1,$x2,$y2,$x3,$y3) ? 1 : 0;


sub sign {
    my($x1,$y1,$x2,$y2,$x3,$y3) = @_;
    return ($x1 - $x3) * ($y2 - $y3) - ($x2 - $x3) * ($y1 - $y3);
}

sub point_in_triangle {
    my($xp,$yp, $x1,$y1,$x2,$y2,$x3,$y3) = @_;

    my $d1 = sign($xp,$yp, $x1,$y1, $x2,$y2);
    my $d2 = sign($xp,$yp, $x2,$y2, $x3,$y3);
    my $d3 = sign($xp,$yp, $x3,$y3, $x1,$y1);

    my $has_neg = ($d1 < 0) || ($d2 < 0) || ($d3 < 0);
    my $has_pos = ($d1 > 0) || ($d2 > 0) || ($d3 > 0);

    return !($has_neg && $has_pos);
}
