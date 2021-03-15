#!/usr/bin/perl
# 
# Task 2: "Triangle Sum
# 
# You are given a triangle array.
# 
# Write a script to find the minimum path sum from top to bottom.
# 
# When you are on index i on the current row then you may move to either
# index i or index i + 1 on the next row.
# 
# Example 1:
# 	Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
# 	Output: 8
# 
# Explanation: The given triangle
# 
#             1
#            2 4
#           6 4 9
#          5 1 7 2
# 
# The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
# 
#              [1]
#            [2]  4
#            6 [4] 9
#           5 [1] 7 2
# 
# Example 2:
# 
# 	Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
# 	Output: 7
# 
# Explanation: The given triangle
# 
#             3
#            3 1
#           5 2 3
#          4 3 1 3
# 
# The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
# 
#              [3]
#             3  [1]
#            5 [2] 3
#           4 3 [1] 3
# "
# 
# My notes: nice question.  Superficially: try all paths, keep
# track of the smallest score.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: triangle-sum [--debug] 'triangle string'\n"
	unless GetOptions( "debug" => \$debug )
	    && @ARGV==1;

my $tristr = shift @ARGV;

my @row = parsetristr( $tristr );

say "Input: $tristr";
#say Dumper( \@row );

my( $min, $minpath ) = minimumtrisum( @row );
chop $minpath;
say "Output: $min";
say " (Path $minpath)";

#
# my @row = parsetristr( $tristr );
#	Parse a triangle string, as shown above in
#	the various example, lots of []..  Returns
#	a triangular 2-d array.
#
fun parsetristr( $str )
{
	$str =~ s/^\s*\[\s*//;
	$str =~ s/^\s*\[\s*//;
	$str =~ s/\s*\]\s*$//;
	$str =~ s/\s*\]\s*$//;

	my @rowstr = split( /\s*\]\s*, \[\s*/, $str );
	my @result;
	my $row;
	for( my $rn=0; $row = shift @rowstr; $rn++ )
	{
		my @onerow = split(/\s*,\s*/,$row);
		my $nor = @onerow;
		die "bad tristr $str, row $rn, row:$row, onerow:".
			Dumper(\@onerow) unless $nor == $rn+1;
		push @result, \@onerow;
	}
	return @result;
}


#
# my( $minsum, $minpath ) = minimumtrisum( @m );
#	Find the minimum triangle sum (and the path leading
#	to that min sum ) in triangle matrix @m
#
fun minimumtrisum( @m )
{
	# start min off at sum( all elements in @m )
	my $min = 0;
	foreach my $row (@m)
	{
		$min += $_ for @$row;
	}
	#say "initial min: $min";

	my $minpath = "";
	path_rec( "", 0, 0, 0, \$min, \$minpath, @m );

	return ( $min, $minpath );
}


#
# path_rec( $path, $sum, $row, $col, $min, $bestpath, @m );
#	Recursively search all possible paths from $row,$col downwards,
#	finding the minimum of all of the paths' sums.  $sum is the
#	sum of values above row $row to this point (along $path).  $$min
#	is the minimum sum discovered so far (and $$bestpath is path leading
#	to $$min, which we update as we find better ones.
#
fun path_rec( $path, $sum, $row, $col, $min, $bestpath, @m )
{
	my $nrows = @m;
	my $el = $m[$row][$col];
	say "entry: pr($path, ($row,$col): el:$el, m:$$min,s:$sum)" if $debug;
	$sum += $el;
	$path .= "$el-";
	if( $row == $nrows-1 )
	{
		# ok, reached bottom of triangle
		say "pr: ($row,$col): reached bottom row, path=$path, sum=$sum"
			if $debug;
		if( $sum < $$min )
		{
			$$min = $sum;
			$$bestpath = $path;
		}
	} else
	{
		# onto next row
		$row++;

		# two paths to try: [col] and [col+1]
		path_rec( $path, $sum, $row, $col, $min, $bestpath, @m );
		path_rec( $path, $sum, $row, $col+1, $min, $bestpath, @m );
	}
}
