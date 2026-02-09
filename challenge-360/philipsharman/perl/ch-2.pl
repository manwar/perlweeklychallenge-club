#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 360 - Task 2
#	===================================
#	"Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK2
#
# 	v 1.0 	- Written by Philip Sharman, examine($input)
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::More 'tests' => 11;

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_0();
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
sub test_0 {
	my $LESS_THAN    = -1;
	my $EQUALS       = 0;
	my $GREATER_THAN = +1;
	my ( $result, $expectedResult );

	$result         = _compare( 'a', 'b' );
	$expectedResult = $LESS_THAN;
	is( $result, $expectedResult );

	$result         = _compare( 'a', 'a' );
	$expectedResult = $EQUALS;
	is( $result, $expectedResult );

	$result         = _compare( 'b', 'a' );
	$expectedResult = $GREATER_THAN;
	is( $result, $expectedResult );

	$result         = _compare( 'a', 'B' );
	$expectedResult = $LESS_THAN;
	is( $result, $expectedResult );

	$result         = _compare( 'B', 'c' );
	$expectedResult = $LESS_THAN;
	is( $result, $expectedResult );
}

sub test_1 {
	my $input          = 'The quick brown fox';
	my $result         = examine( $input );
	my $expectedResult = 'brown fox quick The';
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my $input          = 'Hello    World!   How   are you?';
	my $result         = examine( $input );
	my $expectedResult = 'are Hello How World! you?';
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my $input          = 'Hello';
	my $result         = examine( $input );
	my $expectedResult = 'Hello';
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my $input          = 'Hello, World! How are you?';
	my $result         = examine( $input );
	my $expectedResult = 'are Hello, How World! you?';
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my $input          = 'I have 2 apples and 3 bananas!';
	my $result         = examine( $input );
	my $expectedResult = '2 3 and apples bananas! have I';
	is( $result, $expectedResult, 'Test 5' );
}

sub test_6 {
	my $input          = '222 33';
	my $result         = examine( $input );
	my $expectedResult = '222 33';            # Correct?  Or should we return '33 222'?
	is( $result, $expectedResult, 'Test 6' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( $input ) {
	my @words = split( /\s+/, $input );
	my @sorted = sort { _compare( $a, $b ) } @words;
	return join( ' ', @sorted );
}

##############################################################################################################
# Case-insensitive comparison.
sub _compare( $char1, $char2 ) {
	return lc( $char1 ) cmp lc( $char2 );
}

##############################################################################################################

