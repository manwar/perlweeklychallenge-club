#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 357 - Task 1
#	===================================
#	"Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174)."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2026-01-19
##############################################################################################################
use 5.36.0;
use strict;
use List::Util;
use Test::Exception;
use Test::More 'tests' => 9;

##############################################################################################################
###     GLOBALS                                                                                            ###
##############################################################################################################
my $KAPREKARS_CONSTANT = 6174;

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

say "=" x 110;
say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my $input          = 3534;
	my $result         = examine( $input );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my $input          = 6174;
	my $result         = examine( $input );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my $input          = 9998;
	my $result         = examine( $input );
	my $expectedResult = 5;
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my $input          = 1001;
	my $result         = examine( $input );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my $input          = 9000;
	my $result         = examine( $input );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 5' );
}

sub test_6 {
	my $input          = 1111;
	my $result         = examine( $input );
	my $expectedResult = -1;
	is( $result, $expectedResult, 'Test 6' );
}

sub test_7 {
	my $input          = 0;
	my $result         = examine( $input );
	my $expectedResult = -1;
	is( $result, $expectedResult, 'Test 7' );
}

sub test_8 {
	my $input          = 2111;
	my $result         = examine( $input );
	my $expectedResult = 5;
	is( $result, $expectedResult, 'Test 8' );
}

sub test_9 {
	my $input          = '2111x';
	Test::Exception::throws_ok {  examine( $input ); } qr/Invalid input/, 'Test 9';
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
# See
#	https://en.wikipedia.org/wiki/6174
sub examine( $n ) {
	say "=" x 110;
	say "Examining '$n' ...";
	
	die "Invalid input. n = '$n'." if $n =~ /[^0-9]/;

	# ------------------------------------------------------------------------------------------------------ #
	if ( $n == $KAPREKARS_CONSTANT ) {
		say "N iterations: 0";
		return 0;
	}

	# ------------------------------------------------------------------------------------------------------ #
	my $nIteration = 1;
	while ( $n != $KAPREKARS_CONSTANT ) {
		say "Iteration $nIteration:";

		# Pad left with zeros
		$n = sprintf( "%04d", $n );

		# Split the number into digits
		my @digits = split( //, $n );

		# Check to see that there are at least two different digits
		my @unique = List::Util::uniq( @digits );
		if ( scalar( @unique ) < 2 ) {
			say "We did not find at least two different digits. Returning -1.";
			say "=" x 110;
			return -1;
		}

		# Get numbers formed from ascending and descending digits
		my @ascending  = sort @digits;
		my @descending = reverse sort @digits;
		my $n1         = join( '', @ascending );
		my $n2         = join( '', @descending );

		die "This should not happen. n1 = n2." if $n1 == $n2;

		if ( $n1 < $n2 ) {
			$n = $n2 - $n1;
			say "Result = $n2 - $n1 = $n";
		} else {
			$n = $n1 - $n2;
			say "Result = $n1 - $n2 = $n";
		}

		if ( $n == $KAPREKARS_CONSTANT ) {
			say "Found it!";
			say "N iterations: $nIteration";
			say "=" x 110;
			return $nIteration;
		} else {
			$nIteration++;
		}
	}

	# ------------------------------------------------------------------------------------------------------ #
	die "This should not happen. n = '$n'.";
}

##############################################################################################################
