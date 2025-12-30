#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 354 - Task 2
#	===================================
#	"You are given m x n matrix and an integer, $k > 0.
#	Write a script to shift the given matrix $k times."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK2
#
#	Notes:
#	- This script shifts the matrix by doing doing this:
#		1) Change the matrix to a one-dimensional array.
#		2) Shift the elements of that array.
#		3) Transform that array back to a two-dimensional matrix.
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-29
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::More 'tests' => 7;

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_1();
test_2();
test_3();
test_4();
test_5();
test_6();
test_7();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @matrix = ( [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], );
	my $k      = 1;
	my @result = shiftMatrix( \@matrix, $k );
	# 	PHS::showDataStructure( \@result );
	my @expectedResult = ( [ 9, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ], );
	is_deeply( \@result, \@expectedResult, 'Test 1' );
}

sub test_2 {
	my @matrix         = ( [ 10, 20 ], [ 30, 40 ], );
	my $k              = 1;
	my @result         = shiftMatrix( \@matrix, $k );
	my @expectedResult = ( [ 40, 10 ], [ 20, 30 ], );
	is_deeply( \@result, \@expectedResult, 'Test 2' );
}

sub test_3 {
	my @matrix         = ( [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], );
	my $k              = 1;
	my @result         = shiftMatrix( \@matrix, $k );
	my @expectedResult = ( [ 6, 1 ], [ 2, 3 ], [ 4, 5 ], );
	is_deeply( \@result, \@expectedResult, 'Test 3' );
}

sub test_4 {
	my @matrix         = ( [ 1, 2, 3 ], [ 4, 5, 6 ], );
	my $k              = 5;
	my @result         = shiftMatrix( \@matrix, $k );
	my @expectedResult = ( [ 2, 3, 4 ], [ 5, 6, 1 ], );
	is_deeply( \@result, \@expectedResult, 'Test 4' );
}

sub test_5 {
	my @matrix         = ( [ 1, 2, 3, 4 ] );
	my $k              = 1;
	my @result         = shiftMatrix( \@matrix, $k );
	my @expectedResult = ( [ 4, 1, 2, 3 ] );
	is_deeply( \@result, \@expectedResult, 'Test 5' );
}

# Test empty input
sub test_6 {
	my @matrix         = ();
	my $k              = 10;
	my @result         = shiftMatrix( \@matrix, $k );
	my @expectedResult = ();
	is_deeply( \@result, \@expectedResult, 'Test 6' );
}

# Test k = 0;
sub test_7 {
	my @matrix         = ( [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], );
	my $k              = 0;
	my @result         = shiftMatrix( \@matrix, $k );
	my @expectedResult = ( [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], );
	is_deeply( \@result, \@expectedResult, 'Test 7' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub shiftMatrix( $matrix_arrayRef, $k ) {
	die                          if $k < 0;
	return @{ $matrix_arrayRef } if $k == 0;

	# Shift all the elements right.  Move the end element to the beginning.
	my @oneDimensionalArray = _matrixToArray( $matrix_arrayRef );
	my @shiftedOneDimensionalArray;
	for ( 1 .. $k ) {
		my $lastElement = pop( @oneDimensionalArray );
		@shiftedOneDimensionalArray = $lastElement;
		push( @shiftedOneDimensionalArray, @oneDimensionalArray );

		@oneDimensionalArray = @shiftedOneDimensionalArray;
	}

	my ( $nRows, $nCols ) = _getSize( $matrix_arrayRef );
	my @newMatrix = _arrayToMatrix( \@shiftedOneDimensionalArray, $nRows, $nCols );
	return @newMatrix;
}

##############################################################################################################
# Converts a 2-dimensional matrix to a 1-dimensional array
sub _matrixToArray( $matrix_arrayRef ) {
	my @array;
	for my $subArrayRef ( @{ $matrix_arrayRef } ) {
		my @subArray = @{ $subArrayRef };
		push( @array, @subArray );
	}

	return @array;
}

##############################################################################################################
# Gets the number of rows and number of columns of a matrix
# (We assume that the input is valid. IE, that all the rows have the same number of columns.)
sub _getSize( $matrix_arrayRef ) {
	my @matrix = @{ $matrix_arrayRef };
	return ( 0, 0 ) if scalar( @matrix ) == 0;    # Handle empty matrix.

	my $nRows = scalar( @matrix );

	my @firstRow = @{ $matrix[ 0 ] };
	my $nCols    = scalar( @firstRow );

	return ( $nRows, $nCols );
}

##############################################################################################################
# Converts a 1-dimensional array into a 2-dimensional matrix.
sub _arrayToMatrix( $arrayRef, $nRows, $nCols ) {
	return () if $nRows == 0 && $nCols == 0;

	my @array = @{ $arrayRef };
	die unless scalar( @array ) == $nRows * $nCols;

	my @newMatrix;
	my $n = 0;
	for ( 1 .. $nRows ) {
		my @row;
		for ( 1 .. $nCols ) {
			push( @row, $array[ $n ] );
			$n++;
		}
		push( @newMatrix, \@row );
	}

	return @newMatrix;
}

##############################################################################################################

