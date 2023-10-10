#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Date::Calc qw(Day_of_Week Days_in_Month);

sub main ( $year, $month, $week, $dofw ) {
    # Day of the week for the first of the month (1 - Monday, 7 - Sunday)
    my $first_weekday = Day_of_Week( $year, $month, 1 );

    # To get the first day of week we take the diff between the two values. If
    #  it is negative, add 7 days
    my $day_of_month = 1 + $dofw - $first_weekday;
    if ( $day_of_month < 1 ) {
        $day_of_month += 7;
    }

    # Now add the weeks
    $day_of_month += ( $week - 1 ) * 7;

    if ( $day_of_month > Days_in_Month( $year, $month ) ) {
        # This date does not exist
        say 0;
    }
    else {
        # Print the day of month
        say $day_of_month;
    }

}

main(@ARGV);