#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _is_leap_year {
    my $year = shift;
    return 1 if $year % 400 == 0;
    return 0 if $year % 100 == 0;
    return 1 if $year % 4 == 0;
    return 0;
}

sub main {
    my @long_years = ();

    # January 1st 1990 was a Monday
    my $day_of_week = 1;
    my $year        = 1900;

    while ( $year <= 2100 ) {
        my $leap = _is_leap_year($year);

        # It's a long year if January 1st was a Thursday or Wednesday if
        #   a leap year
        if ( $day_of_week == 4 or ( $leap and $day_of_week == 3 ) ) {
            push @long_years, $year;
        }

        # See you next year
        $year++;
        $day_of_week = ( $day_of_week + 1 + $leap ) % 7;
    }

    say join ', ', @long_years;
}

main();
