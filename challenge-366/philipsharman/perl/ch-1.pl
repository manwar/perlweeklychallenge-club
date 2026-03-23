#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 366 - Task 1
#	===================================
#	"You are given an array of words and a string (contains only lowercase English letters).
#	Write a script to return the number of words in the given array that are a prefix of the given string."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
#
# 	v 1.0 	- Written by Philip Sharman, 2026-03-23
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::Exception;
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
test_7();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @array          = ( "a", "ap", "app", "apple", "banana" );
	my $str            = "apple";
	my $result         = examine( \@array, $str );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my @array          = ( "cat", "dog", "fish" );
	my $str            = "bird";
	my $result         = examine( \@array, $str );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my @array          = ( "hello", "he", "hell", "heaven", "he" );
	my $str            = "hello";
	my $result         = examine( \@array, $str );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my @array          = ( "", "code", "coding", "cod" );
	my $str            = "coding";
	my $result         = examine( \@array, $str );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my @array          = ( "p", "pr", "pro", "prog", "progr", "progra", "program" );
	my $str            = "program";
	my $result         = examine( \@array, $str );
	my $expectedResult = 7;
	is( $result, $expectedResult, 'Test 5' );
}

# Check that only prefixes match, not other places
sub test_6 {
	my @array          = ( "foo" );
	my $str            = "barfoo";
	my $result         = examine( \@array, $str );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 6' );
}

# Check invalid input
sub test_7 {
	my @array = ( ".*", "f.*", "f." );
	my $str   = "fubar";

	Test::Exception::throws_ok {
		my $result = examine( \@array, $str );
	}
	qr /Invalid input/,
	'Test 7';

}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( $arrayRef, $str ) {
	my @array = @{ $arrayRef };

	my $count = 0;
	for my $item ( @array ) {
		say "Invalid input" unless $item =~ /^[a-zA-Z]*$/;
		die "Invalid input" unless $item =~ /^[a-zA-Z]*$/;
		if ( $str =~ /^$item/ ) {
			say "Found: '$item' in '$str'.";
			$count++;
		}
	}

	return $count;
}

##############################################################################################################
