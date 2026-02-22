#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 361 - Task 1
#	===================================
#	"You are given a positive integer (<= 100).
#	Write a script to return Zeckendorf Representation of the given integer."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2026-02-16
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::Exception;
use Test::More 'tests' => 7;

use Algorithm::Combinatorics;    # https://metacpan.org/pod/Algorithm::Combinatorics

##############################################################################################################
###     GLOBALS                                                                                            ###
##############################################################################################################
my @gFibonacciNumbers = ( 1, 2, 3, 5, 8, 13, 21, 34, 55, 89 );

my %gIndexOf;
$gIndexOf{ 1 }  = 1;
$gIndexOf{ 2 }  = 2;
$gIndexOf{ 3 }  = 3;
$gIndexOf{ 5 }  = 4;
$gIndexOf{ 8 }  = 5;
$gIndexOf{ 13 } = 6;
$gIndexOf{ 21 } = 7;
$gIndexOf{ 34 } = 8;
$gIndexOf{ 55 } = 9;
$gIndexOf{ 89 } = 10;

my $VERBOSE = true;

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_0();
test_00();
test_1();
test_2();
test_3();
test_4();
test_5();

say "=" x 110;
say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
# Check that we can find a representation for all numbers from 1 to 100.
sub test_0 {
	for my $int ( 1 .. 100 ) {
		$VERBOSE = true;
		my @result = getZeckendorfRepresentation( $int );    # Should not die
	}
	say "=" x 110;
	pass( 'Test 0' );
}

# Check that our test of consecutive Fibonacci numbers works.
sub test_00 {
	my @representation = ( 5, 8, 13 );
	throws_ok { check( @representation ) } qr/Some numbers in the representation are consecutive Fibonacci numbers/, 'Test 00';
	return;
}

sub test_1 {
	my $int            = 4;
	my @result         = getZeckendorfRepresentation( $int );
	my @expectedResult = ( 3, 1 );
	is( @result, @expectedResult, 'Test 1' );
}

sub test_2 {
	my $int            = 12;
	my @result         = getZeckendorfRepresentation( $int );
	my @expectedResult = ( 8, 3, 1 );
	is( @result, @expectedResult, 'Test 2' );
}

sub test_3 {
	my $int            = 20;
	my @result         = getZeckendorfRepresentation( $int );
	my @expectedResult = ( 13, 5, 2 );
	is( @result, @expectedResult, 'Test 3' );
}

sub test_4 {
	my $int            = 96;
	my @result         = getZeckendorfRepresentation( $int );
	my @expectedResult = ( 89, 5, 2 );
	is( @result, @expectedResult, 'Test 4' );
}

sub test_5 {
	my $int            = 100;
	my @result         = getZeckendorfRepresentation( $int );
	my @expectedResult = ( 89, 8, 3 );
	is( @result, @expectedResult, 'Test 5' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub getZeckendorfRepresentation( $int ) {
	say "=" x 110;
	say "Trying to find representation for $int ...";
	die if $int > 100;

	my @representation;
	my $foundIt          = false;
	my @fibonacciNumbers = sort { $b <=> $a } getFibonacciNumbersLessThanOrEqualTo( $int );

	my $sum = 0;
	while ( !$foundIt ) {
		my $candidate += shift @fibonacciNumbers;

		if ( $sum + $candidate <= $int ) {
			$sum += $candidate;
			push( @representation, $candidate );
		}

		if ( $sum == $int ) {
			check( @representation );
			$foundIt = true;

			if ( $VERBOSE ) {
				say "Found it!";
				say join( ' + ', @representation ) . " = " . $sum;
			}

			return @representation;
		}
	}

	die "ERROR: No representation found";
}

##############################################################################################################
# Check that the numbers are not consecutive Fibonacci numbers
sub check( @representation ) {
	return if scalar( @representation ) == 1;    # If there is only one number, then it is automatically okay

	my $lastIndex = -99;
	for my $r ( sort @representation ) {
		my $index      = $gIndexOf{ $r };
		my $difference = $index - $lastIndex;
		die "ERROR: Some numbers in the representation are consecutive Fibonacci numbers" if $difference == 1;
		$lastIndex = $index;
	}

	return;
}

##############################################################################################################
sub getFibonacciNumbersLessThanOrEqualTo( $n ) {
	my @array;

	for my $f ( @gFibonacciNumbers ) {
		if ( $f <= $n ) {
			push( @array, $f );
		}
	}

	return @array;
}

##############################################################################################################
