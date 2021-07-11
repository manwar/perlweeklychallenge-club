#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $time = shift;
    my ( $hour, $minute ) = ( $time =~ /^([0-9]+):([0-9]+)$/ );

    # Sanity check
    die "You must specify an hour and minte value (HH:MM)" unless defined $hour and defined $minute;
    die "The hour must be between 1 and 12"                unless $hour >= 1    and $hour <= 12;
    die "The minute must be between 0 and 59"              unless $minute >= 0  and $minute <= 59;

    # Telling time is silly. If the hour value is 12, make it zero.
    $hour = 0 if $hour == 12;

    # Calculate the angle of each hand (from the 12:00 position)
    my $angle_min  = 360 * $minute / 60;
    my $angle_hour = 360 * ( $hour / 12 + $minute / 720 );

    # Calculate the delta between the two hands
    my $delta = abs( $angle_min - $angle_hour );

    # If the angle is > 180°, we can get a shorter angle from the other side.
    $delta = 360 - $delta if $delta > 180;

    say $delta . '°';
}

main(@ARGV);
