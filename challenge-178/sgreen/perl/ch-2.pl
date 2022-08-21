#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use DateTime;
use DateTime::Format::Strptime;

sub main ( $dt, $hours ) {
    # It's easier to work in minutes
    my $minutes = $hours * 60;

    my $strp = DateTime::Format::Strptime->new( pattern => '%F %H:%M' );

    # Parse the date time input
    my $start = $strp->parse_datetime($dt);

    # Can't start on a weekend
    if ( $start->day_of_week() >= 6 ) {
        die "You can't start in the weekend\n";
    }

    # Can't start outside office hours
    if ( $start->hour < 9 or $start->hour > 18 or ( $start->hour == 18 and $start->minute > 0 ) ) {
        die "You can't start out of hours!\n";
    }

    # Wind the clock back to 9am Monday
    $minutes += ( $start->day_of_week - 1 ) * 9 * 60 + ( $start->hour - 9 ) * 60 + $start->minute;
    my $monday = $start->clone->subtract(
        days    => $start->day_of_week - 1,
        hours   => $start->hour - 9,
        minutes => $start->minute
    );

    # Split the time to go forward into days and minutes
    my $days = int( $minutes / ( 9 * 60 ) );
    $minutes = $minutes % ( 9 * 60 );

    # For every whole 5 days, we need to add the two weekend days
    $days += 2 * int( $days / 5 );

    # Add the offset from 9am Monday, and print the answer
    my $end = $monday->clone()->add( days => $days, minutes => $minutes );
    say $end->strftime('%F %H:%M');
}

main(@ARGV);