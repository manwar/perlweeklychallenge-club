#!/usr/bin/perl
#
# Task 1: "Max Points
# 
# You are given set of co-ordinates @N.
# 
# Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.
# 
# Example 1:
# 
# 	|
# 	|     x
# 	|   x
# 	| x
# 	+ _ _ _ _
# 
# 	Input: (1,1), (2,2), (3,3)
# 	Output: 3
# 
# Example 2:
# 
# 	|
# 	|
# 	| x       x
# 	|   x
# 	| x   x
# 	+ _ _ _ _ _
# 
# 	Input: (1,1), (2,2), (3,1), (1,3), (5,3)
# 	Output: 3
# "
# 
# My notes: hmm.. I can't see an obvious way to do this cleanly.  Some thought needed.
# Perhaps try every pair of points, make a line, then check all remaining points to
# see if they're on that same line?  Sounds like quite a lot of work.  Also, how does
# one element of @N store an (X,Y) point?  and for that matter, what input format should
# we take?  how about each point is of the form x,y on input, eg. 1,1
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug = 0;
die "Usage: max-points-on-line [--debug] P1 P2...Pn\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>1;
my @N = @ARGV;

#
# my( $m, $c ) = findline( $x1, $y1, $x2, $y2 );
#	Find the straight line connecting ($x1,$y1) and ($x2,$y2),
#	[which cannot be a vertical line, ie. x1!=x2],
#	return $m and $c of the form y=m x + c
#
fun findline( $x1, $y1, $x2, $y2 )
{
	die "findline: bad input ($x1,$y1) and ($x2,$y2): same x => vertical line\n"
		if $x1==$x2;

	# y1=m * x1 + c         (1)
	# y2=m * x2 + c         (2)
	# mult (1) by x2, and (2) by x1:
	# x2 * y1=m * x1 * x2 + c * x2    (1a)
	# x1 * y2=m * x2 * x1 + c * x1    (2a)
	# sub (2a) from (1a):
	# x2 * y1-x1 * y2=c * x2 - c * x1 (3)
	# refactor slightly
	# x2 * y1-x1 * y2=c * (x2 - x1) (3a)
	# rearrange:
	# c = (x2 * y1 - x1 * y2) / (x2-x1)
	my $c = ( $x2 * $y1 - $x1 * $y2 ) / ($x2-$x1);
	# rearrange (1) in form m=...
	my $m;
	if( $x1!=0 )
	{
		# m = (y1 - c) / x1
		$m = ($y1-$c) / $x1;
	} else
	{
		# m = (y2 - c) / x2
		$m = ($y2-$c) / $x2;
	}
	return( $m, $c );
}


#
# my $n = countpointsonline( $m, $c, @N );
#	Count how many points in @N (each point of the form x,y)
#	are on the line y = $m x + $c..  return the count.
#
fun countpointsonline( $m, $c, @N )
{
	my $n = 0;
	foreach my $point (@N)
	{
		my( $x, $y ) = split(/,/, $point, 2);
		$n++ if $y == $m * $x + $c;
	}
	return $n;
}


my $maxpointsonline=0;

for( my $pos0=0; $pos0<@N-1; $pos0++ )
{
	my $p1 = $N[$pos0];
	my( $x1, $y1 ) = split(/,/, $p1, 2);
	for( my $pos1=$pos0+1; $pos1<@N; $pos1++ )
	{
		my $p2 = $N[$pos1];
		my( $x2, $y2 ) = split(/,/, $p2, 2);
		die "bad input: $p2 can't be same as $p1\n" if $x1==$x2 && $y1==$y2;
		my $pointsonline;
		if( $x1==$x2 )
		{
			say "$p1..$p2: vertical line: x=$x1";
			$pointsonline = grep { /^$x1,/ } @N;
			say "$pointsonline points on vertical line x=$x1" if $debug;
		} else
		{
			my( $m, $c ) = findline( $x1, $y1, $x2, $y2 );
			say "$p1..$p2: line: y=${m}x+$c" if $debug;
			$pointsonline = countpointsonline( $m, $c, @N );
			say "$pointsonline points on line y=$m x + $c" if $debug;
		}
		if( $pointsonline > $maxpointsonline )
		{
			$maxpointsonline = $pointsonline;
			say "best so far: $pointsonline points on vertical line x=$x1" if $debug;
		}
	}
}

say $maxpointsonline;
