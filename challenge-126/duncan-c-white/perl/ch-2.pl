#!/usr/bin/perl
# 
# Task 2: "Minesweeper Game
# 
# You are given a rectangle with points marked with either x or *.
# Please consider the x as a land mine (DCW adds: and a * as a non-landmine).
# 
# Write a script to print a rectangle with numbers and x as in the
# Minesweeper game.
# 
# A number in a square of the minesweeper game indicates the number
# of mines within the neighbouring squares (usually 8), also implies
# that there are no bombs on that square.
# 
# Example
# 
# Input:
#     x * * * x * x x x x
#     * * * * * * * * * x
#     * * * * x * x * x *
#     * * * x x * * * * *
#     x * * * x * * * * x
# 
# Output:
#     x 1 0 1 x 2 x x x x
#     1 1 0 2 2 4 3 5 5 x
#     0 0 1 3 x 3 x 2 x 2
#     1 1 1 x x 4 1 2 2 2
#     x 1 1 3 x 2 0 0 1 x
# "
# 
# My notes: also looks pretty easy.  It's not the WHOLE minesweeper game,
#  just the "work out what the finished puzzle looks like"
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: minesweeper [-d|--debug]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==0;

#
# my @board = read_board( $fh );
#	Read the board from input file $fh, building
#	a 2D array of rows x columns, skipping any amount
#	of whitespace.  Every non-blank character is either
#	an 'x' (meaning "this cell is a mine") or '*' (meaning
#	"this cell is not a mine").  We'd better check that
#	every row has the same number of columns..
#
fun read_board( $fh )
{
	my @board;
	my $ncols = -1;
	while( <$fh> )
	{
		chomp;
		last unless /[x*]/;
		s/^\s+//;
		s/\s+$//;
		s/\s\s+/ /g;
		my @row = split( /\s/ );
		$ncols = @row if $ncols == -1;
		my $cols = @row;
		die "read_board: line $_ has $cols columns (earlier lines ".
		    "have $ncols columns)\n" unless $cols == $ncols;
		push @board, \@row;
	}
	return @board;
}


#
# show_board( @b );
#	Show the board @b.
#
fun show_board( @b )
{
	foreach my $row (@b)
	{
		say join(' ', @$row );
	}
}


#
# my $val = mark( $r, $c, $cell, $board );
#	Mark cell $cell ($r,$c) on @$board; return 'x' for mine
#	or a number 0..8 for number of surrounding mines.
#
fun mark( $r, $c, $cell, $board )
{
	return 'x' if $cell eq 'x';
	my $cols = @{$board->[0]};
	my $count = 0;
	foreach my $rn ($r-1..$r+1)
	{
		foreach my $cn ($c-1..$c+1)
		{
			next if $rn == $r && $cn == $c;
			next if $rn < 0 || $rn >= @$board;
			next if $cn < 0 || $cn >= $cols;
			$count++ if $board->[$rn][$cn] eq 'x';
		}
	}
	return $count;
}


#
# my @output = minesweep( @board );
#	Solve the problem: given a board in which mines are marked with 'x'
#	and non-mines as a '*', count up the mines near each cell and return
#	the marked, mineswept, output.
#
fun minesweep( @board )
{
	my @result;
	foreach my $r (0..$#board)
	{
		my $row = $board[$r];
		my @newrow;
		foreach my $c (0..$#$row)
		{
			my $cell = $row->[$c];
			my $newcell = mark( $r, $c, $cell, \@board );
			push @newrow, $newcell;
		}
		push @result, \@newrow;
	}
	return @result;
}


my @board = read_board( \*STDIN );
#show_board( @board );
#exit 0;

my @output = minesweep( @board );
show_board( @output );
