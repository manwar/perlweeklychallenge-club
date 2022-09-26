#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Date::Calc 'Delta_Days';

sub main ( $date1, $date2 ) {
    # Make date2 the latest date
    if ( $date2 lt $date1 ) {
        ( $date2, $date1 ) = ( $date1, $date2 );
    }

    # Split the date parts
    my ( $year1, $month1, $day1 ) = split /-/, $date1;
    my ( $year2, $month2, $day2 ) = split /-/, $date2;

    # Calculate the years between the two dates. If date2 is earlier in the
    #  year than date1, then the year difference is one less
    my $years = $year2 - $year1;
    if ( $month2 < $month1 or ( $month2 == $month1 and $day2 < $day1 ) ) {
        $years--;
    }

    # Calculate the days difference
    my $days =
      Delta_Days( $year1, $month1, $day1, $year2 - $years, $month2, $day2 );

    # Print the output
    my @diff = ();
    if ( $years > 1 ) {
        push @diff, "$years years";
    }
    elsif ( $years == 1 ) {
        push @diff, '1 year';
    }

    if ( $days > 1 ) {
        push @diff, "$days days";
    }
    elsif ( $days == 1 ) {
        push @diff, '1 day';
    }

    say join ' ', @diff;
}

main(@ARGV);