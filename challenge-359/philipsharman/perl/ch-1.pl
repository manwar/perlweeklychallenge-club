#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 359 - Task 1
#	===================================
#	"You are given a positive integer, $int.
#	Write a function that calculates the additive persistence of a positive integer and also return the digital root.
#	-  Digital root is the recursive sum of all digits in a number until a single digit is obtained.
#	-  Additive persistence is the number of times you need to sum the digits to reach a single digit.
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2026-02-04
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use List::Util;
use Test::More 'tests' => 10;

##############################################################################################################
###     GLOBALS                                                                                            ###
##############################################################################################################

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_1();
test_2();
test_3();
test_4();
test_5();
test_6();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my $input = 38;
	my ( $actualPersistence, $actualRoot ) = examine( $input );
	my $expectedPersistence = 2;
	my $expectedRoot        = 2;
	is( $actualPersistence, $expectedPersistence, 'Test 1' );
	is( $actualRoot,        $expectedRoot,        'Test 1' );
}

sub test_2 {
	my $input = 7;
	my ( $actualPersistence, $actualRoot ) = examine( $input );
	my $expectedPersistence = 0;
	my $expectedRoot        = 7;
	is( $actualPersistence, $expectedPersistence, 'Test 2' );
	is( $actualRoot,        $expectedRoot,        'Test 2' );
}

sub test_3 {
	my $input = 999;
	my ( $actualPersistence, $actualRoot ) = examine( $input );
	my $expectedPersistence = 2;
	my $expectedRoot        = 9;
	is( $actualPersistence, $expectedPersistence, 'Test 3' );
	is( $actualRoot,        $expectedRoot,        'Test 3' );
}

sub test_4 {
	my $input = 1999999999;
	my ( $actualPersistence, $actualRoot ) = examine( $input );
	my $expectedPersistence = 3;
	my $expectedRoot        = 1;
	is( $actualPersistence, $expectedPersistence, 'Test 4' );
	is( $actualRoot,        $expectedRoot,        'Test 4' );
}

sub test_5 {
	my $input = 101010;
	my ( $actualPersistence, $actualRoot ) = examine( $input );
	my $expectedPersistence = 1;
	my $expectedRoot        = 3;
	is( $actualPersistence, $expectedPersistence, 'Test 5' );
	is( $actualRoot,        $expectedRoot,        'Test 5' );
}

sub test_6 {
	my $input = 0;
	my ( $actualPersistence, $actualRoot ) = examine( $input );
	my $expectedPersistence = 0;
	my $expectedRoot        = 0;
	is( $actualPersistence, $expectedPersistence, 'Test 6' );
	is( $actualRoot,        $expectedRoot,        'Test 6' );
}


##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( $input ) {
	die "Invalid input" if $input =~ /[^\d]/;

	my $root        = $input;
	my $persistence = 0;
	while ( length( $root ) > 1 ) {
		my @digits      = split( //, $root );
		my $sumOfDigits = List::Util::sum( @digits );
		$root  = $sumOfDigits;
		$persistence++;
	}

	return ( $persistence, $root );
}

##############################################################################################################
