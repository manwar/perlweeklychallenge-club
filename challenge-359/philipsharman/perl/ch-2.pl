#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 359 - Task 2
#	===================================
#	"You are given a word containing only alphabets,
#	Write a function that repeatedly removes adjacent duplicate characters from a string until no adjacent
#	duplicates remain and return the final word.?
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK2
#
# 	v 1.0 	- Written by Philip Sharman, 2026-02-02
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::More 'tests' => 6;

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
	my $input          = 'aabbccdd';
	my $result         = '';
	my $expectedResult = examine( $input );
	is( $expectedResult, $result, 'Test 1' );
}

sub test_2 {
	my $input          = 'abccba';
	my $result         = '';
	my $expectedResult = examine($input);
	is( $expectedResult, $result, 'Test 2' );
}

sub test_3 {
	my $input          = 'abcdef';
	my $result         = 'abcdef';
	my $expectedResult = examine($input);
	is( $expectedResult, $result, 'Test 3' );
}

sub test_4 {
	my $input          = 'aabbaeaccdd';
	my $result         = 'aea';
	my $expectedResult = examine($input);
	is( $expectedResult, $result, 'Test 4' );
}

sub test_5 {
	my $input          = 'mississippi';
	my $result         = 'm';
	my $expectedResult = examine( $input );
	is( $expectedResult, $result, 'Test 5' );
}

sub test_6 {
	my $input          = '';
	my $result         = '';
	my $expectedResult = examine($input);
	is( $expectedResult, $result, 'Test 6' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( $string ) {
	if ($string !~ /(.)\1/) {
		return $string;
	}

	my $n = 1;
	while ( $n > 0 ) {
		$n = ( $string =~ s/(.)\1//g );
	}
	
	return $string;
}

##############################################################################################################
