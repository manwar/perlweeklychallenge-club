#!/usr/bin/perl

# Challenge 093
#
# TASK #1 › Max Points
# Submitted by: Mohammad S Anwar
# You are given set of co-ordinates @N.
#
# Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.
#
# Example 1:
# |
# |     x
# |   x
# | x
# + _ _ _ _
#
# Input: (1,1), (2,2), (3,3)
# Output: 3
# Example 2:
# |
# |
# | x       x
# |   x
# | x   x
# + _ _ _ _ _
#
# Input: (1,1), (2,2), (3,1), (1,3), (5,3)
# Output: 3

use strict;
use warnings;
use 5.030;

# get points
(@ARGV<4 || @ARGV&1==1) and die "Usage: ch-1.pl x y x y x y ...\n";
my @P;
while (my($x, $y) = splice(@ARGV, 0, 2)) {
    push @P, [$x, $y];
}

# for each pair of points forming a line, check if the other points fall on the line
my $points_in_line = 2;
for my $i (0 .. $#P-1) {
    for my $j ($i+1 .. $#P) {           # for each pair
        my $count = 2;
        if ($P[$i][0] == $P[$j][0] && $P[$i][1] == $P[$j][1]) {
            die "points must be different\n";
        }
        for my $k (0 .. $#P) {          # check all other points
            if ($k != $i && $k != $j) {
                # compute cross product
                my $dxc = $P[$k][0] - $P[$i][0];
                my $dyc = $P[$k][1] - $P[$i][1];

                my $dxl = $P[$j][0] - $P[$i][0];
                my $dyl = $P[$j][1] - $P[$i][1];

                my $cross = $dxc * $dyl - $dyc * $dxl;
                if ($cross == 0) {      # Point Pk lies in line [Pi,Pj]
                    $count++;
                }
            }
        }
        if ($count > $points_in_line) {
            $points_in_line = $count;
        }
    }
}

say $points_in_line;
