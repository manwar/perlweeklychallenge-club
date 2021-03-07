#!/usr/bin/perl
# 
# Task 2: "Origin-containing Triangle
# Submitted by: Stuart Little
# 
# You are given three points in the plane, as a list of six co-ordinates:
# A=(x1,y1), B=(x2,y2) and C=(x3,y3).
# 
# Write a script to find out if the triangle formed by the given three
# co-ordinates contain origin (0,0).
# 
# Print 1 if found otherwise 0.
# 
# Example 1:
# 
# 	Input: A=(0,1), B=(1,0) and C=(2,2)
# 
# 	Output: 0 because that triangle does not contain (0,0).
# 
# Example 2:
# 
# 	Input: A=(1,1), B=(-1,1) and C=(0,-3)
# 
# 	Output: 1 because that triangle contains (0,0) in its interior.
# 
# Example 3:
# 
# 	Input: A=(0,1), B=(2,0) and C=(-6,0)
# 
# 	Output: 1 because (0,0) is on the edge connecting B and C.
# "
# 
# My notes: oh, God.  Geometry.  I hate geometry.  Intuitively I've no
# idea how to do this, so need to Google for solutions.  Many different
# ways, vectors, cross products, etc.  Easiest to understand is from
# www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
# and it seems to work (even it compares areas with "==").  Hmm, this seems
# easier than Task 1!
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: triangle-contains-origin x1 y1 x2 y2 x3 y3\n"
	    unless @ARGV==6;

my( $x1, $y1, $x2, $y2, $x3, $y3 ) = @ARGV;

say "\nInput: A($x1,$y1), B($x2,$y2), C($x3,$y3)";

my $isinside = isInside( $x1, $y1, $x2, $y2, $x3, $y3, 0, 0 );
say "\nOutput: $isinside - ". ( $isinside ? "Inside" : "Outside" );


#
# my $area = area( $x1, $y1, $x2, $y2, $x3, $y3 );
#	Calculate area of triangle formed by (x1, y1),  
#	(x2, y2) and (x3, y3).
#
fun area( $x1, $y1, $x2, $y2, $x3, $y3 )
{
	return abs(($x1*($y2-$y3) + $x2*($y3-$y1)+ $x3*($y1-$y2))/2.0);
}

#
# my $isinside = isInside( $x1, $y1, $x2, $y2, $x3, $y3, $x, $y );
#	Check whether point P(x, y) lies inside the triangle formed  
#	by A(x1, y1), B(x2, y2) and C(x3, y3)
#
fun isInside( $x1, $y1, $x2, $y2, $x3, $y3, $x, $y )
{
   # Calculate area of triangle ABC
   my $A = area( $x1, $y1, $x2, $y2, $x3, $y3); 
  
   # Calculate area of triangle PBC
   my $A1 = area( $x, $y, $x2, $y2, $x3, $y3); 
  
   # Calculate area of triangle PAC
   my $A2 = area( $x1, $y1, $x, $y, $x3, $y3); 
  
   # Calculate area of triangle PAB
   my $A3 = area( $x1, $y1, $x2, $y2, $x, $y); 
    
   # Check if sum of A1, A2 and A3 is same as A
   return ($A == $A1 + $A2 + $A3) ? 1 : 0; 
}

