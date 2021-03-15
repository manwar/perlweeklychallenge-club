#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

# You are given a time (12 hour / 24 hour).
#
# Write a script to convert the given time from 12 hour format to 24 hour format and vice versa.
#
# Ideally we expect a one-liner.

my @times =
    sort { $b =~ /m/ <=> $a =~ /m/ }
    sort

    (
    '5:14',  '05:15 pm', '05:15pm', '05:15 am', '05:15am', '17:15',
    '19:15', '07:15 pm', '07:15pm', '12:00am',  '12:00pm', '00:00',
    '12:00', '24:00',    '7:7am',   '7:7pm'
    );

for my $time (@times) {
    say join "\t", '', $time, ' <=> ', switch_time($time);
    say '';
}

# 12pm is noon
# 12am is midnight
sub switch_time ( $time ) {
    my $out = '';

    # 12-hour time
    if ( $time =~ /m$/mix ) {
        my ( $hr, $min, $ampm ) = $time =~ /(\d+):(\d+)\s*(am|pm|)/mix;
        $out = join ':',
            (
            $ampm eq 'am'
            ? ( 
                $hr == 0 ? '00': $hr 
                )
            : (
                $hr == '12'
                ? sprintf '%02d',
                $min
                : sprintf '%02d',
                $hr + 12
            )
            ),
            ( sprintf '%02d', $min );
    }

    # 24-hour time
    else {
        my ( $hr, $min ) = $time =~ /(\d+):(\d+)/mix;
        $out = join '',
            (
            $hr == 0 || $hr == 24
            ? 12
            : ( $hr > 12 ? $hr % 12 : $hr )
            ),
            (':'),
            ( sprintf '%02d', $min ),
            ( $hr < 12 ? 'am' : 'pm' );
    }
    return $out;
}

        
