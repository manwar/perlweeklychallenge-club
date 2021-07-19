#!/usr/bin/perl

use strict;
use warnings;

my @args = ("03:10", "04:00", "12:55", "06:30", "01:05", "01:07");

foreach(@args){
    printf("%5s -> %4d\n", $_, clock_angle($_));
}

exit(0);



sub clock_angle{

    my $angle;
    my $hour;
    my $minute;

    # Extract hours and minutes from the
    # first argument
    ($hour, $minute) = split(':', $_[0]);
    $hour %= 12;

    # Calculate difference between the
    # positions of the minute hand and hour
    # hand, taking into account the
    # latter's motion past the top of the
    # hour
    $angle = abs(5.5 * $minute - 30 * $hour);

    # Make sure we report the minor angle
    if($angle > 180){
        $angle = 360 - $angle;
    }

    return($angle);

}



