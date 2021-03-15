#!/usr/bin/perl
# 
# Task 1: "Pack a Spiral
# Submitted by: Stuart Little
# 
# You are given an array @A of items (integers say, but they can be anything).
# 
# Your task is to pack that array into an MxN matrix spirally
# counterclockwise, as tightly as possible.
# 
# 'Tightly' means the absolute value |M-N| of the difference has to be as
# small as possible.
# 
# Example 1:
# 
# 	Input: @A = (1,2,3,4)
# 
# 	Output:
# 
# 	    4 3
# 	    1 2
# 
# Since the given array is already a 1x4 matrix on its own, but that's
# not as tight as possible. Instead, you'd spiral it counterclockwise into
# 
#     4 3
#     1 2
# 
# Example 2:
# 
# 	Input: @A = (1..6)
# 
# 	Output:
# 
# 	    6 5 4
# 	    1 2 3
# 
# 	or
# 
# 	    5 4
# 	    6 3
# 	    1 2
# 
# 	Either will do as an answer, because they're equally tight.
# 
# Example 3:
# 
# 	Input: @A = (1..12)
# 
# 	Output:
# 
# 	       9  8  7 6
# 	      10 11 12 5
# 	       1  2  3 4
# 
# 	or
# 
# 	       8  7 6
# 	       9 12 5
# 	      10 11 4
# 	       1  2 3
# "
# 
# My notes: ok, interesting question.  First, need to find "tightest" MxN
# where abs(M-N) is minimum, easy.  Second, need to build MxN array via
# a "counterclockwise spiral starting at bottom corner".  Not trivial, but
# should be relatively easy.   Hmmm.. actually, I can't see a particularly
# quick and easy way, I'm sure I'm missing something.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: pack-spiral [--debug] list of numbers\n"
	unless GetOptions( "debug" => \$debug )
	    && @ARGV>0;

my @v = @ARGV;

my $nvals = @v;
my( $m, $n ) = findtightestMxN( $nvals );
say "nvals=$nvals, best m=$m, best n=$n" if $debug;

my @mat = spiral( $m, $n, @v );
say mat2str( @mat );


#
# my( $m, $n ) = findtightestMxN( $nvals );
#	Given $nvals, the number of values, find the tightest
#	("most square" M x N == $nvals.
#
fun findtightestMxN( $nvals )
{
	my $limit = int(sqrt($nvals));

	my $bestm = 1;
	my $bestn = $nvals;
	my $bestdiff = $nvals-1;

	foreach my $m (1..$limit)
	{
		next unless $nvals % $m == 0;
		my $n = $nvals / $m;
		my $diff = abs($m-$n);
		next unless $diff < $bestdiff;
		$bestm = $m;
		$bestn = $n;
		$bestdiff = $diff;
	}

	return ($bestm, $bestn);
}


#
# my $str = mat2str( @mat );
#	Generate a printable version of the 2-d matrix @mat.
#
fun mat2str( @mat )
{
	my $result = "";
	foreach my $row (@mat)
	{
		$result .= join( "  ",
			map {
				defined $_ ? sprintf("%2d",$_) : ' ?'
			} @$row ) . "\n";
	}
	return $result;
}


#
# my @mat = spiral( $m, $n, @v );
#	Make an M x N 2d matrix containing the values from @v
#	packed into a counterclockwise spiral starting from the
#	lower left corner.
#
our @the_mat;	# shared between rest of functions below..
our @vals;	# ditto..

fun spiral( $m, $n, @v )
{
	@the_mat = map { [ (undef) x $n ] } 1..$m;
	@vals = @v;

	# start going east from (m-1, -1)
	east( $m-1, -1, $m, $n );

	return @the_mat;
}


#
# east( $currm, $currn, $m, $n );
#	Move EAST $n times using values from global @vals, adding
#	them to global $the_mat[$currm][$currn..], then carry the spiral
#	on to an M-1 x N matrix, NORTH, then WEST..
#
fun east( $currm, $currn, $m, $n )
{
	my $mstr = "E($currm,$currn,$m,$n):\n".mat2str(@the_mat);
	say $mstr if $debug;
	foreach my $i (1..$n)
	{
		return unless @vals;
		die "run out of values in $mstr\n" unless @vals;
		my $val = shift @vals;
		$currn++;
		$the_mat[$currm][$currn] = $val;
	}

	# have now dealt with current row, (m-1) x n matrix to fill, north
	north( $currm, $currn, $m-1, $n ) if @vals;
}


#
# north( $currm, $currn, $m, $n );
#	Move NORTH $m times using values from global @vals, adding
#	them to global $the_mat[$currm][$currn..], then carry the spiral
#	on (WEST, then SOUTH, then EAST, then NORTH again...)
#
fun north( $currm, $currn, $m, $n )
{
	my $mstr = "N($currm,$currn,$m,$n):\n".mat2str(@the_mat);
	say $mstr if $debug;
	foreach my $i (1..$m)
	{
		return unless @vals;
		die "run out of values in $mstr\n" unless @vals;
		my $val = shift @vals;
		$currm--;
		$the_mat[$currm][$currn] = $val;
	}


	# have now dealt with current col, m x (n-1) matrix to fill, west..
	west( $currm, $currn, $m, $n-1 ) if @vals;
}


#
# west( $currm, $currn, $m, $n );
#	Move WEST $n times using values from global @vals, adding
#	them to global $the_mat[$currm][$currn..], then carry the spiral
#	on (SOUTH, then EAST...)
#
fun west( $currm, $currn, $m, $n )
{
	my $mstr = "W($currm,$currn,$m,$n):\n".mat2str(@the_mat);
	say $mstr if $debug;
	foreach my $i (1..$n)
	{
		return unless @vals;
		die "run out of values in $mstr\n" unless @vals;
		my $val = shift @vals;
		$currn--;
		$the_mat[$currm][$currn] = $val;
	}

	south( $currm, $currn, $m-1, $n ) if @vals;
}


#
# south( $currm, $currn, $m, $n );
#	Move SOUTH $m times using values from global @vals, adding
#	them to global $the_mat[$currm][$currn..], then carry the spiral
#	on (EAST, then NORTH again...)
#
fun south( $currm, $currn, $m, $n )
{
	my $mstr = "S($currm,$currn,$m,$n):\n".mat2str(@the_mat);
	say $mstr if $debug;
	foreach my $i (1..$m)
	{
		return unless @vals;
		die "run out of values in $mstr\n" unless @vals;
		my $val = shift @vals;
		$currm++;
		$the_mat[$currm][$currn] = $val;
	}

	east( $currm, $currn, $m, $n-1 ) if @vals;
}
