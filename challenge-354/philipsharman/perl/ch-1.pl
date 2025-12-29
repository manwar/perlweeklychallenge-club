#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 354 - Task 1
#	===================================
#	"You are given an array of distinct integers.
#	Write a script to find all pairs of elements with the minimum absolute difference."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-29
##############################################################################################################
use 5.36.0;
use strict;

use Algorithm::Combinatorics;
use boolean qw(true false);
use List::Util;
use Test::More 'tests' => 10;

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
test_8();
test_9();
test_10();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @ints           = ( 4, 2, 1, 3 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ 1, 2 ], [ 2, 3 ], [ 3, 4 ] );
	is_deeply( \@result, \@expectedResult, 'Test 1' );
}

sub test_2 {
	my @ints           = ( 10, 100, 20, 30 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ 10, 20 ], [ 20, 30 ] );
	is_deeply( \@result, \@expectedResult, 'Test 2' );
}

sub test_3 {
	my @ints           = ( -5, -2, 0, 3 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ -2, 0 ] );
	is_deeply( \@result, \@expectedResult, 'Test 3' );
}

sub test_4 {
	my @ints           = ( 8, 1, 15, 3 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ 1, 3 ] );
	is_deeply( \@result, \@expectedResult, 'Test 4' );
}

sub test_5 {
	my @ints           = ( 12, 5, 9, 1, 15 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ 9, 12 ], [ 12, 15 ] );
	is_deeply( \@result, \@expectedResult, 'Test 5' );
}

# Test empty input
sub test_6 {
	my @ints           = ();
	my @result         = examine( @ints );
	my @expectedResult = ();
	is_deeply( \@result, \@expectedResult, 'Test 6' );
}

# Test identical input
sub test_7 {
	my @ints           = ( 1, 1, 1 );
	my @result         = examine( @ints );
	my @expectedResult = ();
	is_deeply( \@result, \@expectedResult, 'Test 7' );
}

# Test one number in the input
sub test_8 {
	my @ints           = ( 1 );
	my @result         = examine( @ints );
	my @expectedResult = ();
	is_deeply( \@result, \@expectedResult, 'Test 8' );
}

# Test two numbers in the input
sub test_9 {
	my @ints           = ( 1, 2 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ 1, 2 ] );
	is_deeply( \@result, \@expectedResult, 'Test 9' );
}

# Test negative numbers
sub test_10 {
	my @ints           = ( -9, -7, -5, -3, 0, 99 );
	my @result         = examine( @ints );
	my @expectedResult = ( [ -9, -7 ], [ -7, -5 ], [ -5, -3 ] );
	is_deeply( \@result, \@expectedResult, 'Test 10' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( @array ) {
	return () if ( scalar( @array ) <= 1 );

	# 1) Find all the differences
	my @findings;
	my @differences;
	my @pairs = Algorithm::Combinatorics::variations( \@array, 2 );
	for my $arrayRef ( @pairs ) {
		die unless ref( $arrayRef ) eq 'ARRAY';

		my @pair = @{ $arrayRef };
		my $n1   = $pair[ 0 ];
		my $n2   = $pair[ 1 ];

		next if $n1 >= $n2;

		my $diff = $n2 - $n1;
		push( @findings,    "$n1,$n2,$diff" );
		push( @differences, $diff );
	}
	# Sort the 'findings' strings, by the first number
	@findings = sort _sortFindings ( @findings );

	# 2) Find the minimum difference
	return () if scalar( @differences ) == 0;    # This will happen if all the input is identical
	my $minimumDifference = List::Util::min( @differences );

	# 3) Find which pairs give the minium difference
	my @pairsToReturn;
	for my $item ( @findings ) {
		my @numbers = split( /,/, $item );
		die unless scalar( @numbers ) == 3;
		my $thisDiff = $numbers[ 2 ];

		if ( $thisDiff == $minimumDifference ) {
			my $pair = [ $numbers[ 0 ], $numbers[ 1 ] ];
			push( @pairsToReturn, $pair );
		}
	}

	return @pairsToReturn;
}

##############################################################################################################
sub _sortFindings {
	my @numbersA = split( /,/, $a );
	my @numbersB = split( /,/, $b );

	if ( $numbersA[ 0 ] < $numbersB[ 0 ] ) {
		return -1;
	} elsif ( $numbersA[ 0 ] == $numbersB[ 0 ] ) {
		return 0;
	} else {
		return 1;
	}
}

##############################################################################################################
