#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 353 - Task 1
#	===================================
#	"You are given an array of sentences.
#	Write a script to return the maximum number of words that appear in a single sentence."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK1
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-22
##############################################################################################################
use 5.36.0;
use strict;
use Test::More 'tests' => 8;    # <==  The number of tests. Change as required.

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
test_8();
test_9();
test_10();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @sentences      = ( "Hello world", "This is a test", "Perl is great" );
	my $result         = countWords( @sentences );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my @sentences      = ( "Single" );
	my $result         = countWords( @sentences );
	my $expectedResult = 1;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my @sentences      = ( "Short", "This sentence has seven words in total", "A B C", "Just four words here" );
	my $result         = countWords( @sentences );
	my $expectedResult = 7;
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my @sentences      = ( "One", "Two parts", "Three part phrase", "" );
	my $result         = countWords( @sentences );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my @sentences      = ( "The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question" );
	my $result         = countWords( @sentences );
	my $expectedResult = 10;
	is( $result, $expectedResult, 'Test 5' );
}

# Test leading and trailing whitespace, and multiple whitespace
sub test_6 {
	my @sentences      = ( "   One    Two    Three    " );
	my $result         = countWords( @sentences );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 6' );
}

# Test newlines, tabs, etc
sub test_7 {
	my @sentences      = ( "\nOne\tTwo\n\nThree\n\n\n" );
	my $result         = countWords( @sentences );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 7' );
}

# Test Unicode whitespace
# See
#	https://spaces.mau.fi/
# Question: If two strings are separated by a 'Zero width space' should that count as two words or one?
# Currently, we count it as one.
sub test_8 {
	my $noBreakSpace   = chr( 0x00A0 );
	my $sixPerEmSpace  = chr( 0x2006 );
	my $zeroWidthSpace = chr( 0x200b );
	my @sentences      = ( "One" . $noBreakSpace . "Two" . $sixPerEmSpace . "Thr" . $zeroWidthSpace . "ee" );
	my $result         = countWords( @sentences );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 8' );
}

# Test all whitespace
sub test_9 {
	my @sentences      = ( "               " );
	my $result         = countWords( @sentences );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 9' );
}

# Test no whitespace
sub test_10 {
	my @sentences      = ( "" );
	my $result         = countWords( @sentences );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 10' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub countWords( @array ) {
	my $maxCount = 0;

	for my $sentence ( @array ) {
		$sentence =~ s/^\s+//;    # Chop off leading whitespace
		$sentence =~ s/\s+$//;    # Chop off trailing whitespace;

		my $numberOfWords;
		if ( $sentence =~ /^$/ ) {
			# If the sentence was only whitespace, then there are no words
			$numberOfWords = 0;

		} else {
			# Count the number of occurrences of runs of whitespace
			my $numberOfDividingSpaces = ( $sentence =~ s{\s+}{}g );

			# The number of words is the number of occurrences of whitespace plus 1
			$numberOfWords = $numberOfDividingSpaces + 1;
		}

		# Get the maximum
		if ( $numberOfWords > $maxCount ) {
			$maxCount = $numberOfWords;
		}
	}

	return $maxCount;
}

##############################################################################################################
