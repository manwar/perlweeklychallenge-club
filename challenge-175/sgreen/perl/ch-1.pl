#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Date::Calc (qw(This_Year Days_in_Month Day_of_Week));

# Use the year provided or the current year if it wasn't
sub main ( $year = This_Year() ) {

    foreach my $month ( 1 .. 12 ) {
        # Get the number of days in a month
        my $last_day = Days_in_Month( $year, $month );

        # Get the day of week of the last day (Monday is 1, Sunday is 7)
        my $dow = Day_of_Week( $year, $month, $last_day );

        # Take off the number of days to get last Sunday
        say sprintf '%d-%02d-%02d', $year, $month, $last_day - $dow % 7;
    }
}

main(@ARGV);
