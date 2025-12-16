#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 351 - Task 2
#	===================================
#	"You are given an array of numbers.
#	Write a script to return true if the given array can be re-arranged to form an arithmetic progression, otherwise return false."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK2
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-08
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use feature 'say';
use feature 'signatures';

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_1();
test_2();
test_3();
test_3b();
test_4();
test_5();
test_6();
test_7();
test_8();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
# Input that is empty. The result should be false.
sub test_1 {
	say "Test 1";
	my @num            = ();
	my $result         = examine( @num );
	my $expectedResult = false;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Input that is one number. The result should be false.
sub test_2 {
	say "Test 2";
	my @num            = ( 2000 );
	my $result         = examine( @num );
	my $expectedResult = false;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Input that is two or more identical numbers. The result should be true.
sub test_3 {
	say "Test 3";
	my @num            = ( 0, 0 );         
	my $result         = examine( @num );
	my $expectedResult = true;
	_testIt( $expectedResult, @num );

	my @num2            = ( 0, 0, 0, 0 );    
	my $result2         = examine( @num2 );
	my $expectedResult2 = true;
	_testIt( @num2, $expectedResult2 );
}

##############################################################################################################
# Input that is two different numbers. The result should be true (for any two numbers).
sub test_3b {
	say "Test 3b";
	my @num            = ( 0, 1 );         
	my $result         = examine( @num );
	my $expectedResult = true;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Example 1 from the challenge.
sub test_4 {
	say "Test 4";
	my @num            = (1, 3, 5, 7, 9);
	my $result         = examine( @num );
	my $expectedResult = true;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Example 2 from the challenge.
sub test_5 {
	say "Test 5";
	my @num            = (9, 1, 7, 5, 3);
	my $result         = examine( @num );
	my $expectedResult = true;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Example 3 from the challenge.
sub test_6 {
	say "Test 6";
	my @num            = (1, 2, 4, 8, 16);
	my $result         = examine( @num );
	my $expectedResult = false;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Example 4 from the challenge.
sub test_7 {
	say "Test 7";
	my @num            = (5, -1, 3, 1, -3);
	my $result         = examine( @num );
	my $expectedResult = true;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
# Example 5 from the challenge.
sub test_8 {
	say "Test 8";
	my @num            = (1.5, 3, 0, 4.5, 6);
	my $result         = examine( @num );
	my $expectedResult = true;
	_testIt( $expectedResult, @num );
}

##############################################################################################################
sub _testIt( $expectedResult, @array ) {
	my $result = examine( @array );
	die unless $result == $expectedResult;
	say "Test passed.\n";
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
# Return true if the (sorted) array is an arithmetic progression.
sub examine( @array ) {
	# This cannot be an arithmetic progression if there are only zero or one elements in the array.
	if ( scalar( @array ) <= 1 ) {
		return false;
	}

	# This is automatically an arithmetic progression if there are two elements in the array.
	if ( scalar( @array ) == 2 ) {
		return true;
	}

	# Otherwise, test the differences ...
	
	# Sort the array (numerically, not by strings)
	my @sortedArray = sort { $a <=> $b } @array;
	
	my $firstDiff = $sortedArray[ 1 ] - $sortedArray[ 0 ];
	
	for ( my $i = 1 ; $i < scalar( @sortedArray ) - 1 ; $i++ ) {
		my $diff = $sortedArray[ $i + 1 ] - $sortedArray[ $i ];
		return false if ( $diff != $firstDiff );
	}

	return true;
}

##############################################################################################################
