#!/usr/bin/env perl

# Challenge 293
#
# Task 2: Boomerang
# Submitted by: Mohammad Sajid Anwar
# You are given an array of points, (x, y).
#
# Write a script to find out if the given points are a boomerang.
#
# A boomerang is a set of three points that are all distinct and not in a straight line.
#
# Example 1
# Input: @points = ( [1, 1], [2, 3], [3,2] )
# Output: true
# Example 2
# Input: @points = ( [1, 1], [2, 2], [3, 3] )
# Output: false
# Example 3
# Input: @points = ( [1, 1], [1, 2], [2, 3] )
# Output: true
# Example 4
# Input: @points = ( [1, 1], [1, 2], [1, 3] )
# Output: false
# Example 5
# Input: @points = ( [1, 1], [2, 1], [3, 1] )
# Output: false
# Example 6
# Input: @points = ( [0, 0], [2, 3], [4, 5] )
# Output: true

use Modern::Perl;

@ARGV==3 or die "usage: $0 'n n' 'n n' 'n n'\n";
my @points = @ARGV;
for (@points) {
    $_ = [split ' ', $_];
}

# make the syntax easier to reads
my ($x1,$y1) = @{ $points[0] };
my ($x2,$y2) = @{ $points[1] };
my ($x3,$y3) = @{ $points[2] };

# compute the area of the triangle
my $double_area = abs($x1*($y2-$y3)+$x2*($y3-$y1)+$x3*($y1-$y2));

# if area > 0, points are a boomerang
say $double_area > 0 ? "true" : "false";
