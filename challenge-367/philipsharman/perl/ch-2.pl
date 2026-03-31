#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 367 - Task 2
#	===================================
#	"You are given two events start and end time.
#	Write a script to find out if there is a conflict between the two events.
#	A conflict happens when two events have some non-empty intersection."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
#
#	Note:
#	- We assume that the second event does not start earlier than the first event.  (This makes it possible
#    to parse times that span midnight unambiguously.)
#
# 	v 1.0 	- Written by Philip Sharman, 2026-03-31
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use DateTime;
use Test::More 'tests' => 9;

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

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @event1         = ( "10:00", "12:00" );
	my @event2         = ( "11:00", "13:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = true;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my @event1         = ( "09:00", "10:30" );
	my @event2         = ( "10:30", "12:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my @event1         = ( "14:00", "15:30" );
	my @event2         = ( "14:30", "16:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = true;
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my @event1         = ( "08:00", "09:00" );
	my @event2         = ( "09:01", "10:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my @event1         = ( "23:30", "00:30" );
	my @event2         = ( "00:00", "01:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = true;
	is( $result, $expectedResult, 'Test 5' );
}

sub test_6 {
	my @event1         = ( "08:00", "09:00" );
	my @event2         = ( "08:00", "09:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = true;
	is( $result, $expectedResult, 'Test 6' );
}

sub test_7 {
	my @event1         = ( "00:00", "09:00" );
	my @event2         = ( "20:00", "09:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 7' );
}

sub test_8 {
	my @event1         = ( "23:30", "02:00" );
	my @event2         = ( "03:00", "09:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 8' );
}

sub test_9 {
	my @event1         = ( "20:30", "22:30" );
	my @event2         = ( "00:00", "01:00" );
	my $result         = examine( \@event1, \@event2 );
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 9' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
# Returns true if the events overlap.
sub examine( $event1_arrayRef, $event2_arrayRef ) {
	my $event1_start = $event1_arrayRef->[ 0 ];
	my $event1_end   = $event1_arrayRef->[ 1 ];
	my $event2_start = $event2_arrayRef->[ 0 ];
	my $event2_end   = $event2_arrayRef->[ 1 ];

	# ------------------------------------------------------------------------------------------------------ #
	my ( $event1_start_hour, $event1_start_minute );
	if ( $event1_start =~ /^(\d\d):(\d\d)$/ ) {
		( $event1_start_hour, $event1_start_minute ) = ( $1, $2 );
	} else {
		die;
	}

	my ( $event1_end_hour, $event1_end_minute );
	if ( $event1_end =~ /^(\d\d):(\d\d)$/ ) {
		( $event1_end_hour, $event1_end_minute ) = ( $1, $2 );
	} else {
		die;
	}

	my ( $event2_start_hour, $event2_start_minute );
	if ( $event2_start =~ /^(\d\d):(\d\d)$/ ) {
		( $event2_start_hour, $event2_start_minute ) = ( $1, $2 );
	} else {
		die;
	}

	my ( $event2_end_hour, $event2_end_minute );
	if ( $event2_end =~ /^(\d\d):(\d\d)$/ ) {
		( $event2_end_hour, $event2_end_minute ) = ( $1, $2 );
	} else {
		die;
	}

	# ------------------------------------------------------------------------------------------------------ #
	# Handle things that go over midnight.
	# In cases like this
	# 		@event1 = ("23:30", "00:30")
	# we assume the end time is on the next day after the start time.
	my $date1_end_day_number = ( $event1_end_hour < $event1_start_hour ) ? 2 : 1;

	my $date1_start = DateTime->new(
		'year'   => 2026,
		'month'  => 1,
		'day'    => 1,
		'hour'   => $event1_start_hour,
		'minute' => $event1_start_minute,
	);
	say "date1_start: $date1_start";

	my $date1_end = DateTime->new(
		'year'   => 2026,
		'month'  => 1,
		'day'    => $date1_end_day_number,
		'hour'   => $event1_end_hour,
		'minute' => $event1_end_minute,
	);
	say "date1_end:   $date1_end";

	# ------------------------------------------------------------------------------------------------------ #
	# Handle things that go over midnight.
	# In cases like this
	# 		@event1 = ("23:30", "00:30")
	# 		@event2 = ("00:00", "01:00")
	# we assume that the second event starts on the day after the first event.

	my $date2_day_number = ( $event2_start_hour < $event1_start_hour ) ? 2 : 1;

	my $date2_start = DateTime->new(
		'year'   => 2026,
		'month'  => 1,
		'day'    => $date2_day_number,
		'hour'   => $event2_start_hour,
		'minute' => $event2_start_minute,
	);
	say "date2_start: $date2_start";

	my $date2_end = DateTime->new(
		'year'   => 2026,
		'month'  => 1,
		'day'    => $date2_day_number,
		'hour'   => $event2_end_hour,
		'minute' => $event2_end_minute,
	);
	say "date2_end:   $date2_end";

	# ------------------------------------------------------------------------------------------------------ #
	if ( $date2_start < $date1_end ) {
		say "Overlap found";
		return true;
	} else {
		say "No overlap found";
		return false;
	}
}

##############################################################################################################
