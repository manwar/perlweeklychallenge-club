#!/usr/bin/perl
# 
# Task 2: "Square Points
# 
# You are given coordinates of four points
# i.e. (x1, y1), (x2, y2), (x3, y3) and (x4, y4).
# 
# Write a script to find out if the given four points form a square.
# 
# Example
# 
# 	Input: x1 = 10, y1 = 20
# 	       x2 = 20, y2 = 20
# 	       x3 = 20, y3 = 10
# 	       x4 = 10, y4 = 10
# 	Output: 1 as the given coordinates form a square.
# 
# 	Input: x1 = 12, y1 = 24
# 	       x2 = 16, y2 = 10
# 	       x3 = 20, y3 = 12
# 	       x4 = 18, y4 = 16
# 	Output: 0 as the given coordinates doesn't form a square.
# "
# 
# My notes: sounds surprisingly easy for a task 2.  I guess the points
# can be in any order.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: square-points X1 Y2 X2 Y2 X3 Y3 X4 Y4\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV==8;
my( $x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4 ) = @ARGV;
my @p = ( [$x1,$y1], [$x2,$y2], [$x3,$y3], [$x4,$y4] );

#
# my $square = issquare( @p );
#	Return 1 iff the 4 points in @p make a square, 0 otherwise.
#
fun issquare( @p )
{
	# first, let's sort the coordinates by x-first-and-then-y-if-xs-same
	@p = sort { $a->[0]<=>$b->[0] || $a->[1]<=>$b->[1] } @p;

	#print Dumper \@p;

	return 0 unless $p[0]->[0] == $p[1]->[0];
	return 0 unless $p[2]->[0] == $p[3]->[0];
	my $size = $p[1]->[1] - $p[0]->[1];
	return 0 if $size==0;
	return 0 unless $p[3]->[1] - $p[2]->[1] == $size;
	return 1;
}


my $square = issquare( @p );
say $square;
