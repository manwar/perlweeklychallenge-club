#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #120
#               Task 2 - Clock Angle
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 20210710 04:44:33 PM
#===============================================================================

use strict;
use warnings;

sub calc_angle{
    my $what = shift;

    my ($hour, $min) = split /:/, $what;

    # each minute is 6 degrees
    my $angle_min = 6 * $min;

    # hour hand has moved 30 * whole hours + 0.5 * mins
    my $angle_hour = 30 * $hour + 0.5 * $min;

    my $result_angle = abs($angle_hour - $angle_min);

    # the challenge is asking for the smaller angle
    return $result_angle > 180 ?  360-$result_angle : $result_angle;
}

use Test::More;

is(calc_angle("03:10"), 35);
is(calc_angle("04:00"), 120);
is(calc_angle("10:14"), 137);
done_testing;

