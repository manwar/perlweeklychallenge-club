#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 360 - Task 1
#	===================================
#	"You are given a string and a width.
#	Write a script to return the string that centers the text within that width using asterisks * as padding."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2026-02-09
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
	my $str            = 'Hi';
	my $width          = 5;
	my $result         = pad( $str, $width );
	my $expectedResult = '*Hi**';
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my $str            = 'Code';
	my $width          = 10;
	my $result         = pad( $str, $width );
	my $expectedResult = "***Code***";
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my $str            = 'Hello';
	my $width          = 9;
	my $result         = pad( $str, $width );
	my $expectedResult = '**Hello**';
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my $str            = 'Perl';
	my $width          = 4;
	my $result         = pad( $str, $width );
	my $expectedResult = 'Perl';
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my $str            = 'A';
	my $width          = 7;
	my $result         = pad( $str, $width );
	my $expectedResult = '***A***';
	is( $result, $expectedResult, 'Test 5' );
}

sub test_6 {
	my $str            = '';
	my $width          = 5;
	my $result         = pad( $str, $width );
	my $expectedResult = '*****';
	is( $result, $expectedResult, 'Test 6' );
}

# Test the case where $width is smaller than the length of the string.
sub test_7 {
	my $str            = 'abc';
	my $width          = 0;
	my $result         = pad( $str, $width );
	my $expectedResult = 'abc';
	is( $result, $expectedResult, 'Test 7' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub pad( $str, $width ) {
	# Handle the case where $width is smaller than the length of the string.  (In the case, we just return the string.)
	$width = length( $str ) if $width < length( $str );

	my $stringLength = length( $str );
	my $firstLength  = int( ( $width - $stringLength ) / 2 );
	my $secondLength = $width - $stringLength - $firstLength;

	my $result = '*' x $firstLength;
	$result .= $str;
	$result .= '*' x $secondLength;

	die unless length( $result ) == $width;

	return $result;
}

##############################################################################################################
