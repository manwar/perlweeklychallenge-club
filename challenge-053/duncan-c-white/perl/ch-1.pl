#!/usr/bin/perl
#
# Task 1: "Rotate Matrix
# 
# Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.
# 
# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
# 
# For example, if you rotate by 90 degrees then expected result should be like below
# 
# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]
# "
# 
# My notes: sounds pretty trivial.  Made slightly cuter by an inline package in order
# to use classic Perl OO in order to get autostringification.
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

die "Usage: rotate-matrix (90|180|270)+\n" if @ARGV == 0;


package Matrix;

use parent "Clone";
use overload '""' => \&as_str;

# my $mat = Matrix->new( $matrixstr );
#	Construct and return a new Matrix from $matrixstr,
#	eg a matrix string "1 2 3/4 5 6/7 8 9"
#	builds the matrix
#	( 1, 2, 3,
#	  4, 5, 6,
#	  7, 8, 9 )
#	whereas matrix string "" builds an empty matrix.
#
method new( $class: $matrixstr )
{
	my $mat = [];
	if( $matrixstr )
	{
		my @row = split( m|/|, $matrixstr );
		die "Matrix->new( $matrixstr ): badly formed matrix string, should be 2 '/'s\n"
			unless @row == 3;
		foreach my $rowstr (@row)
		{
			my @col = split( /\s+/, $rowstr );
			die "Matrix->new( $matrixstr ): badly formed matrix string, row $rowstr\n"
				unless @col == 3;
			push @$mat, \@col;
		}
	}
	return bless $mat, $class;
}


#
# my $str = $mat->as_str();
#	Matrix as string: return a printable form of matrix $mat.
#
sub as_str ($)
{
	my( $self ) = @_;

	my @r = map { join( ', ', @$_ ) } @$self;
	my $str = "\n" . join( "\n", @r ) . "\n";
	#say "debug: $str";
	return $str;
}


#
# $mat->rotate90( $n );
#	Rotate $mat by 90 degrees clockwise, $n times.
#
method rotate90( $n )
{
	$n %= 4;
	for my $i (1..$n)
	{
		my $mat = Matrix->new( "" );
		foreach my $col (0..2)
		{
			my @newrow = ();
			foreach my $row (2,1,0)
			{
				push @newrow, $self->[$row][$col];
			}
			$mat->[$col] = \@newrow;
		}
		@$self = @$mat;
	}
}



package main;

# initial matrix
my $initmat = Matrix->new( "1 2 3/4 5 6/7 8 9" );

say "initmat is $initmat";

#my $m2 = Matrix->new( "" );
#say "m2 is $m2";

foreach my $angle (@ARGV)
{
	my $mat = $initmat->clone;
	if( $angle == 90 )
	{
		$mat->rotate90( 1 );
	}
	elsif( $angle == 180 )
	{
		$mat->rotate90( 2 );
	}
	elsif( $angle == 270 )
	{
		$mat->rotate90( 3 );
	} else
	{
		die "bad angle $angle (should be 90|180|270)\n";
	}
	say "$initmat rotated by $angle is $mat";
}
