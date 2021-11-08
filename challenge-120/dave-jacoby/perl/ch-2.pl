#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

my @times = qw{ 3:10 4:00 4:20 6:00 11:59 12:00 3:21 };
@times = map { "11:$_" } 20 .. 65;

for my $time (@times) {
    $time = fix_time($time);
    my $angle = clock_angle($time);
    say join "\t", '', $time, $angle;
}

sub fix_time ($time) {
    my ( $hour, $minute ) = split /:/, $time;
    $hour += 1 if $minute >= 60;
    $minute = sprintf '%02d', $minute % 60;
    $hour   = $hour % 12;
    $hour   = $hour ? $hour : 12;
    return join ':', $hour, $minute;
}

sub clock_angle ($time) {
    my ( $hour, $minute ) = split /:/, $time;
    my $minute_angle = minute_angle($minute);
    my $hour_angle   = hour_angle( $hour, $minute );
    my ( $min, $max ) = sort $minute_angle, $hour_angle;
    my $angle = $max - $min;
    if ( $angle > 180 ) {
        $angle = abs $min - $max;
    }
    if ( $angle > 180 ) {
        $angle = 360 - $angle;
    }
    return $angle;
}

sub hour_angle ( $hour, $minute ) {
    $hour++ if $minute > 60;
    return ( ( $hour % 12 ) * 30 ) + ( ( $minute % 60 ) / 2 );
}

sub minute_angle ($minute) {
    return 6 * ( $minute % 60 );
}
