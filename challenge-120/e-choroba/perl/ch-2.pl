#!/usr/bin/perl
use warnings;
use strict;

sub clock_angle {
    my ($time) = @_;
    my ($h, $m) = split /:/, $time;

    my $angle = abs(($m / 60 + $h) * 30 - $m * 6);
    $angle = 360 - $angle if $angle > 180;
    $angle *= -1 if $angle < 0;
    return $angle
}

use Test2::V0;
plan 10;

is clock_angle('03:10'),   35, 'Example 1';
is clock_angle('04:00'),  120, 'Example 2';

is clock_angle('12:00'),    0, 'Midnight/Noon';
is clock_angle( '1:00'),   30, "One o'clock";
is clock_angle( '2:00'),   60, "Two o'clock";
is clock_angle('18:00'),  180, 'Six PM';
is clock_angle( '6:30'),   15, 'Half past 6';
is clock_angle( '6:33'),  1.5, 'Half past 6';
is clock_angle( '2:11'),  0.5, 'Smallest angle';
is clock_angle('11:55'), 27.5, 'Five to twelve';
