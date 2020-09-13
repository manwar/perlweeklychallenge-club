#!/usr/bin/perl
#
# Task 2: "Lonely X
#
# You are given m x n character matrix consists of O and X only.
# 
# Write a script to count the total number of X surrounded by O only. Print
# 0 if none found.
# 
# Example 1:
# 
# Input: [ O O X ]
#        [ X O O ]
#        [ X O O ]
# 
# Output: 1 as there is only one X at the first row last column surrounded
# by only O.
# 
# Example 2:
# 
# Input: [ O O X O ]
#        [ X O O O ]
#        [ X O O X ]
#        [ O X O O ]
# 
# Output: 2
# 
#     a) First  X found at Row 1 Col 3.
# 
#     b) Second X found at Row 3 Col 4.
# "
# 
# My notes: interesting question, sounds simple but perhaps not quite
# as simple as it sounds.  Especially (obviously) "surrounded by only O"..
# Note that I counted rows and columns from 0, not 1.  So the output I
# generate for the second grid (file grid2) is:
# "2 lonely Xs in grid: [0, 2],[2, 3]"
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(max);

die "Usage: lonely-x ox-filename\n" unless @ARGV==1;
my $filename = shift;

#
# my @g = readgrid($filename);
#	Read the ox grid file, return @g, the grid
#	(an array of array-refs).
#
fun readgrid( $filename )
{
	open( my $infh, '<', $filename ) || die;
	my @result;
	while( <$infh> )
	{
		chomp;
		tr/ \t[]//d;
		die "readgrid: bad line '$_'\n" unless /^[OX]+$/;
		my @ch = split(//);
		push @result, \@ch;
	}
	close($infh);
	return @result;
}

my @dir =
(
	[-1,0],	# up (delta r,c)
	[-1,1], # ne
	[0,1],  # e
	[1,1],  # se
	[1,0],  # down
	[1,-1], # sw
	[0,-1], # w
	[-1,-1],# nw
);


#
# my @sol = findlonelyxs( @grid );
#	Given @grid, a grid (array of array refs) read by readgrid(),
#	find all lonely Xs.  Return an array of [R,C] pairs.
#
fun findlonelyxs( @grid )
{
	my $rows = @grid;
	my $cols = @{$grid[0]};
	#say "debug: rows=$rows, cols=$cols";

	my @result;
	foreach my $r (0..$rows-1)
	{
		foreach my $c (0..$cols-1)
		{
			if( $grid[$r][$c] eq 'X' )
			{
				if( lonelyX( $r, $c, @grid ) )
				{
					#say "debug: found lonely X @ r=$r, c=$c";
					push @result, [$r,$c];
				}
			}
		}
	}
	return @result;
}


#
# my $islonely = lonelyX( $r, $c, @grid );
#	Given that cell ($r,$c) in @grid is an X, is it a lonely one?
#	Return 1 iff it is, otherwise 0.
#
fun lonelyX( $r, $c, @grid )
{
	my $rows = @grid;
	my $cols = @{$grid[0]};

	# build the "str of adjacent cell values" in $adjstr.
	my $adjstr = "";

	foreach my $dir (@dir)
	{
		my( $dr, $dc ) = @$dir;
		my $r2 = $r+$dr;
		my $c2 = $c+$dc;

		# have we fallen off the grid?
		next if $r2<0 || $r2>=$rows || $c2<0 || $c2>=$cols;
		my $ch = $grid[$r2][$c2];
		#say "debug: X pos ($r,$c), adj pos ($r2,$c2) on board, is $ch";
		$adjstr .= $ch;
	}
	#say "debug: X @ ($r,$c): adjstr: $adjstr";

	# not lonely if any 'X' in $adjstr, otherwise lonely
	return $adjstr =~ /X/ ? 0 : 1;
}


my @g = readgrid($filename);
#say Dumper \@g;

my @sol = findlonelyxs( @g );
my $n = @sol;
say "$n lonely Xs in grid: ", join(',',map { my($r,$c)=@$_; "[$r, $c]" } @sol);
