#!/usr/bin/perl
# 
# Task 2: "Adventure of Knight
# Submitted by: Cheok-Yin Fung
# 
# A knight is restricted to move on an 8x8 chessboard. The knight is
# denoted by N and its way of movement is the same as what it is defined in
# Chess. * represents an empty square. x represents a square with treasure.
# 
# The Knight's movement is unique. It may move two squares vertically
# and one square horizontally, or two squares horizontally and one square
# vertically (with both forming the shape of an L).
# 
# There are 6 squares with treasures.
# 
# Write a script to find the path such that Knight can capture all
# treasures. The Knight starts from the top-left square.
# 
#       a b c d e f g h
#     8 N * * * * * * * 8
#     7 * * * * * * * * 7
#     6 * * * * x * * * 6
#     5 * * * * * * * * 5
#     4 * * x * * * * * 4
#     3 * x * * * * * * 3
#     2 x x * * * * * * 2
#     1 * x * * * * * * 1
#       a b c d e f g h
# 
# BONUS: If you believe that your algorithm can output one of the shortest
# possible path.
# "
#
# My notes: looks reasonably straight forward, highly recursive.  Obvious way
# to find a shortest possible path is to generate all paths of length L before
# extending each path of length L to paths of length L+1.  NB: Why not allow
# any number of treasures, not fixed at 6?  Got it working, although it takes
# forever to solve larger problems.
# 

use strict;
use warnings;
use feature 'say';
use List::Util qw(sum);
use Function::Parameters;
use Data::Dumper;

die "Usage: knight-adventure treasurecoords\n" if @ARGV==0;

#
# my $pair = validate_coord( $coord );
#	Validate $coord, a chess coordinate like a3. Die if not valid.
#	Return [$row,$col] pair with both col and row in 1..8.
#
fun validate_coord( $coord )
{
	die "bad coord $coord: wrong length\n" unless length($coord)==2;
	die "bad coord $coord: bad pattern\n" unless
		$coord =~ /^([a-h])([1-8])$/;
	my( $col, $row ) = ( $1, $2 );
	$col = ord($col)+1 - ord('a');
	$row += 0;
	return [$row,$col];
}


my @treas = map { validate_coord($_) } @ARGV;
#say Dumper($_) for @treas;

#
# my $board = makeboard( @treas );
#	Create and return the chess board with the treasures
#	at coords @treas, and the knight at position (8,1).
#
fun makeboard( @treas )
{
	my $board = '.' x 64;
	substr( $board, 0, 1 ) = 'N';
	substr( $board, 8*(8-$_->[0]) + $_->[1]-1, 1 ) = 'x' for @treas;
	return $board;
}


#
# my $str = showcoord( $coord );
#	Show the $coord in human readable form.
#
fun showcoord( $coord )
{
	my( $r, $c ) = @$coord;
	return chr(ord('a')+$c-1).$r;
}


#
# my $str = showboard( $board );
#	Show the $board in human readable form.
#
fun showboard( $board )
{
	my $result = "  a b c d e f g h\n";
	foreach my $r (1..8)
	{
		my $row = 9-$r;
		$result .= "$row ";
		foreach my $c (1..8)
		{
			$result .= substr( $board, 8*($r-1)+($c-1), 1 ). " ";
		}
		$result .= "\n";
	}
	$result .= "  a b c d e f g h\n";
	return $result;
}


#
# my $val = cell( $board, $coord );
#	Extract the value of the cell $coord in board $board.
#	'.': unvisited; 'N': knight's current position;
#	'x': a treasure; 'n': a past position of the knight.
#
fun cell( $board, $coord )
{
	my $pos = 8*(8-$coord->[0]) + $coord->[1]-1;
	#say "debug: cell: pos=$pos";
	return substr( $board, $pos, 1);
}


#
# setcell( \$board, $coord, $val );
#	Set the value of the cell $coord in board $board.
#	'.': unvisited; 'N': knight's current position;
#	'x': a treasure; 'n': a past position of the knight.
#
fun setcell( $board, $coord, $val )
{
	my $pos = 8*(8-$coord->[0]) + $coord->[1]-1;
	#say "debug: setcell: pos=$pos";
	substr( $$board, $pos, 1) = $val;
}


#
# my $coord = findknight( $board );
#	Find the coordinate of the knight in the $board.
#
fun findknight( $board )
{
	foreach my $r (1..8)
	{
		foreach my $c (1..8)
		{
			my $pos = 8*($r-1)+($c-1);
			return [ 9-$r, $c ] if substr( $board, $pos, 1 ) eq 'N';
		}
	}
	die;
}


#
# my @neigh = knightmove( $board, $coord );
#	Find and return a list of all knight moves from $coord
#	on $board (staying on board).
#
fun knightmove( $board, $coord )
{
	my @result;
	my @off = ( [2,1], [1,2], [-1,2], [-2,1],
		    [-2,-1], [-1,-2], [1,-2], [2,-1]
		  );
	foreach my $off (@off)
	{
		my $r = $coord->[0] + $off->[0];
		next if $r > 8 || $r < 1;
		my $c = $coord->[1] + $off->[1];
		next if $c > 8 || $c < 1;
		push @result, [$r,$c] unless
			cell( $board, [ $r, $c ] ) eq 'n';
	}
	return @result;
}


my $board = makeboard( @treas );
#say Dumper $board;
#say showboard( $board );
#my $val = cell( $board, [ 8, 1 ] );
#say "8,1: $val";
#$val = cell( $board, [ 5, 6 ] );
#say "5,6: $val";

#my $knight = findknight( $board );
#my $kn = showcoord($knight);

#my @neigh = knightmove( $board, $knight );
#say "knight moves from $kn:";
#say showcoord($_) for @neigh;

#my $b2 = $board;
#
#setcell( \$b2, [ 8, 1 ], '.' );
#setcell( \$b2, [ 4, 4 ], 'N' );
#say showboard( $b2 );
#
#$knight = findknight( $b2 );
#$kn = showcoord($knight);
#@neigh = knightmove( $b2, $knight );
#say "knight moves from $kn:";
##say showcoord($_) for @neigh;
#setcell( \$b2, $_, 'n' ) for @neigh;
#say showboard( $b2 );

# now, start searching from $board, depth first.
my $ntreas = @treas;

my $soln = breadthfirst( [ $ntreas, $board ] );
say "solution: ";
say showboard($soln);


#
# my $soln = breadthfirst( @bt );
#	Breadth first search, where @bt is a list of
#	( more treasures needed, board ) pairs,
#	return the first board found.
#
fun breadthfirst( @bt )
{
	do
	{
		my @newbt;			# boards of length currlen+1
		foreach my $bt (@bt)
		{
			my( $t, $board ) = @$bt;
			say "debug: trying to find $t treasures in board:";
			say showboard($board);

			my $knight = findknight( $board );
			my $kn = showcoord($knight);

			my @neigh = knightmove( $board, $knight );
			#say "knight at $kn, knight moves: ". join( ' ', map { showcoord($_) } @neigh );
			foreach my $neigh (@neigh)
			{
				my $cell = cell( $board, $neigh );
				#say "debug: neigh: ".showcoord($neigh)." cell=$cell";
				if( $cell eq 'x' )	# unused treasure
				{
					return $board if $t==1;
					my $b2 = $board;
					setcell( \$b2, $knight, 'n' );
					setcell( \$b2, $neigh, 'N' );
					#say "adding [".($t-1).",..] to newbt";
					#say showboard($b2);
					push @newbt, [ $t-1, $b2 ];
				}
				if( $cell eq '.' )	# empty
				{
					my $b2 = $board;
					setcell( \$b2, $knight, 'n' );
					setcell( \$b2, $neigh, 'N' );
					#say "adding [$t,..] to newbt";
					#say showboard($b2);
					push @newbt, [ $t, $b2 ];
				}
			}
		}
		@bt = @newbt;
	} while( @bt );
	die;
}
