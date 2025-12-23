#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 353 - Task 2
#	===================================
#	"You are given three arrays, @codes, @names and @status.
# 	Write a script to validate codes in the given array.
# 	A code is valid when the following conditions are true:
# 	- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
# 	- names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
# 	- status[i] is true.
# 	Return an array of booleans indicating validity: output[i] is true if and only if codes[i], names[i] and status[i] are all valid."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK2
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-22
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::Exception;
use Test::More 'tests' => 5;    # <==  The number of tests. Change as required.

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
	my @codes          = ( "A123",        "B_456",      "C789",        'D@1',      "E123" );
	my @names          = ( "electronics", "restaurant", "electronics", "pharmacy", "grocery" );
	my @status         = ( "true",        "false",      "true",        "true",     "true" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( true, false, true, false, true );
	is_deeply( \@result, \@expectedResult, 'Test 1' );
}

sub test_2 {
	my @codes          = ( "Z_9",      "AB_12",       "G01",     "X99",         "test" );
	my @names          = ( "pharmacy", "electronics", "grocery", "electronics", "unknown" );
	my @status         = ( "true",     "true",        "false",   "true",        "true" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( true, true, false, true, false );
	is_deeply( \@result, \@expectedResult, 'Test 2' );
}

sub test_3 {
	my @codes          = ( "_123",       "123",         "",            "Coupon_A", "Alpha" );
	my @names          = ( "restaurant", "electronics", "electronics", "pharmacy", "grocery" );
	my @status         = ( "true",       "true",        "false",       "true",     "true" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( true, true, false, true, true );
	is_deeply( \@result, \@expectedResult, 'Test 3' );
}

sub test_4 {
	my @codes          = ( "ITEM_1",      "ITEM_2",      "ITEM_3",  "ITEM_4" );
	my @names          = ( "electronics", "electronics", "grocery", "grocery" );
	my @status         = ( "true",        "true",        "true",    "true" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( true, true, true, true );
	is_deeply( \@result, \@expectedResult, 'Test 4' );
}

sub test_5 {
	my @codes          = ( "CAFE_X",     "ELEC_100",    "FOOD_1",  "DRUG_A",   "ELEC_99" );
	my @names          = ( "restaurant", "electronics", "grocery", "pharmacy", "electronics" );
	my @status         = ( "true",       "true",        "true",    "true",     "false" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( true, true, true, true, false );
	is_deeply( \@result, \@expectedResult, 'Test 5' );
}

# Test that empty codes are detected properly.
sub test_6 {
	my @codes          = ( "", );
	my @names          = ( "restaurant" );
	my @status         = ( "true" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( false );
	is_deeply( \@result, \@expectedResult, 'Test 6' );
}

# Test exceptions - the subroutine should die if there are errors in the input
sub test_7 {
	my @codes  = ( "CAFE_X", );
	my @names  = ( "restaurant", "electronics", "grocery", "pharmacy", "electronics" );
	my @status = ( "true",       "true",        "true",    "true",     "false" );
	Test::Exception::dies_ok {
		my @result = examine( \@codes, \@names, \@status );
	}
	'Test - 7a';

	@codes  = ( "CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99" );
	@names  = ( "restaurant", );
	@status = ( "true", "true", "true", "true", "false" );
	Test::Exception::dies_ok {
		my @result = examine( \@codes, \@names, \@status );
	}
	'Test - 7b';

	@codes  = ( "CAFE_X",     "ELEC_100",    "FOOD_1",  "DRUG_A",   "ELEC_99" );
	@names  = ( "restaurant", "electronics", "grocery", "pharmacy", "electronics" );
	@status = ( "true" );
	Test::Exception::dies_ok {
		my @result = examine( \@codes, \@names, \@status );
	}
	'Test - 7c';
}

# Test that invalid codes are detected properly
sub test_8 {
	my @codes          = ( "ABC✔",       "ABC-DEF",    "ABC^DEF" );
	my @names          = ( "restaurant", "restaurant", "restaurant" );
	my @status         = ( "true",       "true",       "true" );
	my @result         = examine( \@codes, \@names, \@status );
	my @expectedResult = ( false, false, false );
	is_deeply( \@result, \@expectedResult, 'Test 8' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( $codes, $names, $status ) {
	my @codes  = @{ $codes };
	my @names  = @{ $names };
	my @status = @{ $status };

	die "Invalid input" unless scalar( @codes ) == scalar( @names ) == scalar( @status );

	my @isValid;
	for ( my $i = 0 ; $i < scalar( @codes ) ; $i++ ) {
		my $isValid = _codeValid( $codes[ $i ] ) && _nameValid( $names[ $i ] ) && _statusValid( $status[ $i ] );
		push( @isValid, $isValid );
	}

	return @isValid;
}

##############################################################################################################
sub _codeValid( $code ) {
	return false if $code =~ /^$/;

	if ( $code =~ /^[a-zA-Z0-9_]+$/ ) {
		return true;
	} else {
		return false;
	}
}

##############################################################################################################
sub _nameValid( $name ) {
	if (   ( $name eq "electronics" )
		or ( $name eq "grocery" )
		or ( $name eq "pharmacy" )
		or ( $name eq "restaurant" ) )
	{
		return true;
	} else {
		return false;
	}
}

##############################################################################################################
sub _statusValid( $status ) {
	if ( $status eq "true" ) {
		return true;
	} else {
		return false;
	}
}

##############################################################################################################
