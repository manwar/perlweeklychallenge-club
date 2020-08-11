#!/usr/bin/perl
#
# Task 1: "Minimum Sum Path
#
# Given an MxN matrix with non-negative integers, write a script to find
# a path from top left to bottom right which minimizes the sum of all
# numbers along its path. You can only move either down or right at any
# point in time.
#
# Example
# 
# Input:
# 
# [ 1 2 3 ]
# [ 4 5 6 ]
# [ 7 8 9 ]
# 
# The minimum sum path looks like this:
# 
# 1->2->3
#       |
#       6
#       |
#       9
# 
# Thus, your script could output: 21 ( 1 -> 2 -> 3 -> 6 -> 9 )
# "
# 
# My notes: sounds like fun.  Input format: CSV rows on command line
# so above is: ./ch-1.pl 1,2,3 4,5,6 7,8,9
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(sum);

die "Usage: min-sum-path row1 row2..\n" if @ARGV==0;
my @m;
foreach my $row (@ARGV)
{
	my @r = split(/,/, $row);
	push @m, \@r;
}
#say Dumper(\@m);

my $rows = @m;
my $cols = @{$m[0]};
my( $min, $minpath ) = minsumpath( $rows, $cols, @m );
say "min sum path: $min ($minpath)";


#
# my( $min, $minpath ) = minsumpath( $r, $c, @m );
#	Find and return the minimum sum path through the matrix @m,
#	which is $r X $c
#
fun minsumpath( $r, $c, @m )
{
	my $min;
	foreach my $row (@m)
	{
		$min += sum(@$row);
	}

	my $minpath = "";
	my $el = $m[0][0];
	search( "$el", $el, 0, 0, $r-1, $c-1, \@m,
		fun ($x, $y)
		{
			if( $x < $min )
			{
				$min = $x;
				$minpath = $y;
			}
		} );
	return ( $min, $minpath );
}


#
# search( $currpath, $currsum, $r, $c, $destr, $destc, $mref, $callback );
#	Given that we've already got $currsum getting to ($r,$c),
#	search all paths through @$mref only going left or down
#	from ($r,$c), and call the $callback(sum, path) whenever we
#	find a complete path (ie. reach $destr and $destc)
#
fun search( $currpath, $currsum, $r, $c, $destr, $destc, $mref, $callback )
{
	if( $r < $destr || $c < $destc )
	{
		if( $r < $destr )
		{
			# go down a row
			my $val = $mref->[$r+1][$c];
			search( "$currpath -> $val", $currsum+$val, $r+1, $c, $destr, $destc,
				$mref, $callback );
		}
		if( $c < $destc )
		{
			# go right a column
			my $val = $mref->[$r][$c+1];
			search( "$currpath -> $val", $currsum+$val, $r, $c+1, $destr, $destc,
				$mref, $callback );
		}
	} elsif( $r == $destr && $c == $destc )
	{
		#say "debug: found path $currpath to $destr, $destc: $currsum";
		$callback->( $currsum, $currpath );
	}
}
