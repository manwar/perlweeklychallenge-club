#!/usr/bin/env perl

# Challenge 120
#
# TASK #2 › Clock Angle
# Submitted by: Mohammad S Anwar
# You are given time $T in the format hh:mm.
#
# Write a script to find the smaller angle formed by the hands of an analog
# clock at a given time.
#
# HINT: A analog clock is divided up into 12 sectors. One sector represents 30
# degree (360/12 = 30).
#
# Example
# Input: $T = '03:10'
# Output: 35 degree
#
# The distance between the 2 and the 3 on the clock is 30 degree.
# For the 10 minutes i.e. 1/6 of an hour that have passed.
# The hour hand has also moved 1/6 of the distance between the 3 and the 4,
# which adds 5 degree (1/6 of 30).
# The total measure of the angle is 35 degree.
#
# Input: $T = '04:00'
# Output: 120 degree

use Modern::Perl;

my $hhmm = shift || "0:0";
my($hh, $mm) = split(/:/, $hhmm, 2);
my($hh_angle, $mm_angle) = clock_angles($hh, $mm);
my $angle = abs($hh_angle - $mm_angle);
if ($angle > 180) { $angle = 360 - $angle; }

say $angle;

sub clock_angles {
    my($hh, $mm) = @_;
    my $mm_angle = $mm/60*360;
    my $hh_angle = ($hh % 12)/12*360 + $mm_angle/360*1/12*360;
    return ($hh_angle, $mm_angle);
}
