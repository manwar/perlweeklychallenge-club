#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 361 - Task 2
#	===================================
#	"You are given a binary matrix (m x n).
#	Write a script to find the celebrity, return -1 when none found.
#	A celebrity is someone, everyone knows and knows nobody."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK2
#
# 	v 1.0 	- Written by Philip Sharman, 2026-02-20
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use List::Util;
use Test::More 'tests' => 6;

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

say "";
say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @party = (
		[ 0, 0, 0, 0, 1, 0 ],    # 0 knows 4
		[ 0, 0, 0, 0, 1, 0 ],    # 1 knows 4
		[ 0, 0, 0, 0, 1, 0 ],    # 2 knows 4
		[ 0, 0, 0, 0, 1, 0 ],    # 3 knows 4
		[ 0, 0, 0, 0, 0, 0 ],    # 4 knows NOBODY
		[ 0, 0, 0, 0, 1, 0 ],    # 5 knows 4
	);
	my $result         = examine( @party );
	my $expectedResult = 4;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my @party = (
		[ 0, 1, 0, 0 ],          # 0 knows 1
		[ 0, 0, 1, 0 ],          # 1 knows 2
		[ 0, 0, 0, 1 ],          # 2 knows 3
		[ 1, 0, 0, 0 ],          # 3 knows 0
	);
	my $result         = examine( @party );
	my $expectedResult = -1;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my @party = (
		[ 0, 0, 0, 0, 0 ],       # 0 knows NOBODY
		[ 1, 0, 0, 0, 0 ],       # 1 knows 0
		[ 1, 0, 0, 0, 0 ],       # 2 knows 0
		[ 1, 0, 0, 0, 0 ],       # 3 knows 0
		[ 1, 0, 0, 0, 0 ],       # 4 knows 0
	);
	my $result         = examine( @party );
	my $expectedResult = 0;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_4 {
	my @party = (
		[ 0, 1, 0, 1, 0, 1 ],    # 0 knows 1, 3, 5
		[ 1, 0, 1, 1, 0, 0 ],    # 1 knows 0, 2, 3
		[ 0, 0, 0, 1, 1, 0 ],    # 2 knows 3, 4
		[ 0, 0, 0, 0, 0, 0 ],    # 3 knows NOBODY
		[ 0, 1, 0, 1, 0, 0 ],    # 4 knows 1, 3
		[ 1, 0, 1, 1, 0, 0 ],    # 5 knows 0, 2, 3
	);
	my $result         = examine( @party );
	my $expectedResult = 3;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my @party = (
		[ 0, 1, 1, 0 ],          # 0 knows 1 and 2
		[ 1, 0, 1, 0 ],          # 1 knows 0 and 2
		[ 0, 0, 0, 0 ],          # 2 knows NOBODY
		[ 0, 0, 0, 0 ],          # 3 knows NOBODY
	);
	my $result         = examine( @party );
	my $expectedResult = -1;
	is( $result, $expectedResult, 'Test 5' );
}

sub test_6 {
	my @party = (
		[ 0, 0, 1, 1 ],          # 0 knows 2 and 3
		[ 1, 0, 0, 0 ],          # 1 knows 0
		[ 1, 1, 0, 1 ],          # 2 knows 0, 1 and 3
		[ 1, 1, 0, 0 ],          # 3 knows 0 and 1
	);
	my $result         = examine( @party );
	my $expectedResult = -1;
	is( $result, $expectedResult, 'Test 6' );
}

sub test_7 {
	my @party = (
		[ 0, 0, 1, 1 ],          # 0 knows 2 and 3
		[ 0, 0, 1, 1 ],          # 1 knows 2 and 3
		[ 0, 0, 0, 0 ],          # 2 knows NOBODY
		[ 0, 0, 0, 0 ],          # 3 knows NOBODY
	);
	my $result         = examine( @party );
	my $expectedResult = -1;
	is( $result, $expectedResult, 'Test 7' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( @party ) {
	say "";

	# ------------------------------------------------------------------------------------------------------ #
	# 1) Find possible celebrities.  (IE, find people who do not know anybody.)
	my @possibleCelebrities;
	my $index = 0;
	for my $arrayRef ( @party ) {
		my @array = @{ $arrayRef };
		my $sum   = List::Util::sum( @array );
		if ( $sum == 0 ) {
			push( @possibleCelebrities, $index );
		}
		$index++;
	}

	if ( scalar( @possibleCelebrities ) == 0 ) {
		say "There are no possible celebrities.";
		return -1;
	} elsif ( scalar( @possibleCelebrities ) == 1 ) {
		say "There is 1 possible celebrity: " . join( ', ', @possibleCelebrities );
	} else {
		say "There are " . scalar( @possibleCelebrities ) . " possible celebrities: " . join( ', ', @possibleCelebrities );
	}

	# ------------------------------------------------------------------------------------------------------ #
	# 2) See if any of the possible celebrities are actual celebrities. (I.E., check if everyone else knows
	#    them.)
	my $actualCelebrity;
	for my $possilbeCelebrityIndex ( @possibleCelebrities ) {
		my $isCelebrity = true;

		$index = 0;
		for my $arrayRef ( @party ) {
			my @array = @{ $arrayRef };

			if ( $index != $possilbeCelebrityIndex ) {
				# say "$index: \$array[ $possilbeCelebrityIndex ] =  $array[ $possilbeCelebrityIndex ]";
				if ( $array[ $possilbeCelebrityIndex ] != 1 ) {
					$isCelebrity = false;
					say "$possilbeCelebrityIndex is not a celebrity.";
					last;
				}
			}
			$index++;
		}

		if ( $isCelebrity ) {
			say "$possilbeCelebrityIndex is a celebrity.";
			$actualCelebrity = $possilbeCelebrityIndex;
		}
	}

	if ( not defined( $actualCelebrity ) ) {
		say "No celebrities found.";
		return -1;
	} else {
		return $actualCelebrity;
	}

	# ------------------------------------------------------------------------------------------------------ #
}

##############################################################################################################
