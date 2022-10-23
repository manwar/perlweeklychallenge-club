#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(min max);
use Date::Calc qw(Day_of_Year);

sub get_dofy ($date) {
    # Turn a date in DD-MM format into day of year'''
    my ( $day, $month ) = split( /-/, $date );
    return Day_of_Year( 2022, $month, $day );
}

sub main (@array) {
    #Calculate the days that foo and bar spent together

    # Convert the input into the day of year
    my $foo_start = get_dofy( $array[0] );
    my $foo_end   = get_dofy( $array[1] );
    my $bar_start = get_dofy( $array[2] );
    my $bar_end   = get_dofy( $array[3] );

    # Make sure they arrive before they leave!
    if ( $foo_end < $foo_start ) {
        die "foo left before they arrived!\n";
    }
    if ( $bar_end < $bar_start ) {
        die "bar left before they arrived!\n";
    }

# The time they spent together is when the last person arrives and the first one leave.
    my $both_start = max( $foo_start, $bar_start );
    my $both_end   = min( $foo_end, $bar_end );

    # Display the days spent together
    if ( $both_end < $both_start ) {
        say '0 days';
    }
    elsif ( $both_start == $both_end ) {
        say '1 day';
    }
    else {
        say +( $both_end - $both_start + 1 ), ' days';
    }
}

main(@ARGV);