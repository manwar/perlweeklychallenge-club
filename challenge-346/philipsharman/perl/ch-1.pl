#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 346 - Task 1
#	===================================
#	"You are given a string containing only ( and ).
#	Write a script to find the length of the longest valid parenthesis."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-346/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-08
##############################################################################################################
use 5.36.0;
use strict;

use boolean qw(true false);
use feature 'say';
use feature 'signatures';
use List::Util;
use Test::More 'tests' => 8;    # <==  The number of tests. Change as required.

##############################################################################################################
###     GLOBALS                                                                                            ###
##############################################################################################################
my $VERBOSE = false;

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

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my $str            = '(()())';
	my $result         = examine( $str );
	my $expectedResult = 6;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my $str            = ')()())';
	my $result         = examine( $str );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my $str            =  '((()))()(((()';
	my $result         = examine( $str );
	my $expectedResult = 8;
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my $str            =  '))))((()(';
	my $result         = examine( $str );
	my $expectedResult = 2;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my $str            =  '()(()';
	my $result         = examine( $str );
	my $expectedResult = 2;
	is( $result, $expectedResult, 'Test 5' );
}

sub test_6 {
	my $str    = '()(())((()))()';
	my $result = examine( $str );
	my $expectedResult = 14;
	is( $result, $expectedResult, 'Test 6' );
}

sub test_7 {
	my $str    = '';
	my $result = examine( $str );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 7' );
}

sub test_8 {
	my $str    = ')))(((';
	my $result = examine( $str );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 8' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( $string ) {
	say "";
	say "Examining: '$string'";

	return 0 if $string eq '';
	die "Invalid input: '$string'" unless $string =~ /^[)(]+$/;

	# We look at smaller and smaller sections of the string each time, chopping off the first letter each time.
	# That way we only need to look for matches that start at position 0.

	my @sizesFound    = ( 0 );
	my @letters       = split( //, $string );
	my $startPosition = 0;
	while ( @letters ) {
		my $subString = join( '', @letters );
		if ( $VERBOSE ) {
			say "Position: $startPosition";
			say "Examining: '$subString'";
		}

		my $parenthesisLevel = 0;
		for ( my $i = 0 ; $i < scalar( @letters ) ; $i++ ) {
			$parenthesisLevel++ if $letters[ $i ] eq '(';
			$parenthesisLevel-- if $letters[ $i ] eq ')';

			if ( $parenthesisLevel < 0 ) {
				last;
			}

			if ( $VERBOSE ) {
				print "i:$i: parenthesisLevel:$parenthesisLevel    ";
				print "." x $parenthesisLevel;
				say $letters[ $i ];
			}

			if ( $parenthesisLevel == 0 ) {
				my $match = substr( $subString, 0, $i + 1 );
				say "Found '$match' at position $startPosition. Size: " . length( $match );
				push( @sizesFound, length( $match ) );
			}
		}

		shift( @letters );
		$startPosition++;
	}

	my $largestSizeFound = List::Util::max( @sizesFound );
	say "Largest size found: $largestSizeFound";

	return $largestSizeFound;
}

##############################################################################################################

