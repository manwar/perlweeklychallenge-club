#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Date::Calc ( 'Day_of_Week', 'leap_year' );

sub main {
    my $year = shift;

    # Sanity check
    die "You must specify the year"       unless defined $year;
    die "Year must be four digits > 1752" unless $year =~ /^[0-9]{4}$/ and $year > 1752;

    # Get the day of week of January 1st, and leap year flag
    my $day_of_week = Day_of_Week( $year, 1, 1 );    # 1 - Monday, 7 - Sunday
    my $leap        = leap_year($year);

    # If the 1st of January is Saturday or Sunday, then the Dec 31st (or
    # Dec 30th in a leap year) isn't a work day.
    my $workdays = ( $day_of_week != 6 and $day_of_week != 7 ) ? 261 : 260;

    # In a leap year, the Dec 31st is two days later than Jan 1st.
    ++$workdays if $leap and $day_of_week != 5 and $day_of_week != 6;

    say $workdays;
}

main(@ARGV);
