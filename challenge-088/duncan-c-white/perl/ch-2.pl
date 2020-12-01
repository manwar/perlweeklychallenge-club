#!/usr/bin/perl
#
# Task 2: "Spiral Matrix
# 
# You are given m x n matrix of positive integers.
# 
# Write a script to print a spiral path throught the matrix as list.
# 
# Example 1:
# 
# Input:
#     [ 1, 2, 3 ]
#     [ 4, 5, 6 ]
#     [ 7, 8, 9 ]
# Output:
#     [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]
# 
# Example 2:
# 
# Input:
#     [  1,  2,  3,  4 ]
#     [  5,  6,  7,  8 ]
#     [  9, 10, 11, 12 ]
#     [ 13, 14, 15, 16 ]
# Output:
#     [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]
# "
# 
# My notes: clearly defined.  Is "a spiral path" clear?  Think so.
# How to do this?  Given non-square matrix:
#  1,  2,  3,  4,  5
#  6,  7,  8,  9, 10
# 11, 12, 13, 14, 15
# 16, 17, 18, 19, 20
# 
# - we first consume whole top row: 1  2  3  4  5
# matrix now:
#  6  7  8  9 10
# 11 12 13 14 15
# 16 17 18 19 20
# - consume whole last column, top to bottom: 10 15 20
# matrix now:
#  6  7  8  9
# 11 12 13 14
# 16 17 18 19
# - consume whole bottom row, backwards: 19 18 17 16
#  matrix now:
#  6  7  8  9
# 11 12 13 14
# - consume whole first column, bottom to top: 11 6
#  matrix now:
#  7  8  9
# 12 13 14
# - repeat: consume whole top row: 7 8 9
#  matrix now:
# 12 13 14
# - consume whole last column: 14
#  matrix now:
# 12 13
# - consume whole bottom row, backwards: 13 12
# matrix empty
#

use strict;
use warnings;
use Data::Dumper;
use Function::Parameters;
use feature 'say';

# Read the matrix ignoring everything but digits and commas..
my @m;
my $rowlen = undef;
while( <> )
{
	chomp;
	tr/0-9,//cd;
	my @row = split( /,/ );
	unless( defined $rowlen )
	{
		$rowlen = @row;
	} else
	{
		die "matrix: line $. ($_) of wrong length, should be $rowlen\n"
			unless $rowlen == @row;
	}
	push @m, \@row;
}
#say Dumper(\@m);

#
# my @l = spiral( $ncols, @m );
#	Trace a spiral path through @m, each row of which has
#	$ncols columns.  Return the list of matrix elements.
#
fun spiral( $ncols, @m )
{
	my @l;
	while( @m )
	{
		# consume top row
		my $toprow = shift @m;
		push @l, @$toprow;

	last if @m==0;

		# consume last column
		foreach my $row (@m)
		{
			my $val = pop(@$row);
			push @l, $val;
		}

		$ncols--;

	last if $ncols==0;

		# consume bottom row, backwards
		my $bottomrow = pop @m;
		push @l, reverse @$bottomrow;

	last if @m==0;

		# consume first column, upwards
		my @rev;
		foreach my $row (@m)
		{
			my $val = shift(@$row);
			push @rev, $val;
		}
		push @l, reverse @rev;

		$ncols--;

	last if $ncols==0;

	}
	return @l;
}

my @l = spiral( $rowlen, @m );
say for @l;

