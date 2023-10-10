#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 237 Task 1: Seize The Day
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

use Time::Piece;
use Time::Seconds;

my @ordinals = qw( zeroth first second third fourth fifth sixth );

sub seize_the_day( $year, $month, $weekday_of_month, $day_of_week ) {

    # my $first_of_month =
	# gmtime( timegm_posix( 0,0,0, 1, $month - 1, $year - 1900 ) );
    # vsay $first_of_month->strftime( "%F is a %A" );

    # Set up a Time::Piece object for the first day of the month.
    # (Good that strptime does not insist in leading zeros!)
    my $first_of_month = Time::Piece->strptime( "$year-$month-1", "%F" );
    vsay $first_of_month->strftime( "%F is a %A" );

    # The Time::Piece day_of_week method is based on 0=Sunday.
    # We map our $day_of_week (1=Monday...7=Sunday) to that range by a '% 7'.
    my $t = $first_of_month
	+ ( ( $day_of_week % 7 )
	    - $first_of_month->day_of_week ) % 7
	    * ONE_DAY;
    $month = sprintf "%02d", $month;
    vsay $t->strftime( "first %A of $year-$month: %A %F" );

    # Add the number of weeks needed.
    $t += 7 * ONE_DAY * ( $weekday_of_month - 1 );

    vsay $ordinals[$weekday_of_month] // "${weekday_of_month}th",
	$t->strftime( " %A of $year-$month: %A %F" );

    # Check whether we are in the next month already.
    my $next_month = $first_of_month->add_months( 1 );

    return $t->mon == $month ? $t->day_of_month : 0;
}

run_tests;

__DATA__
Test 1: December 2023
Input: Year = 2023, Month = 12, Weekday of month = 3, day of week = 2
Output: 19
Test 2: October 2023
Input: Year = 2023, Month = 10, Weekday of month = 1, day of week = 2
Output: 3
