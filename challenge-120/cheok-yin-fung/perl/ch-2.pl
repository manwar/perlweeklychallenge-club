#!/usr/bin/perl
# The Weekly Challenge - 120
# Task 2 Clock Angle
# Usage: $ ch-2.pl "hh:mm"
use strict;
use warnings;
use Test::More tests => 5;

my $T = $ARGV[0] || 0;

unless ($T =~ m/^(\d\d):(\d\d)$/ && $1 <= 24 && $2 <= 59) { 
    die "Please input time in the format \"hh:mm\". \n";
}

#unit: degree(s) per minute
my $hour_hand_rate = 0.5;
my $minute_hand_rate = 6;

print clock_angle($T), " degree", "\n";

sub clock_angle {
    my $time = $_[0];
    my $h = substr($time,0,2);
    my $m = substr($time,-2,2);
    my $deg = abs( ($h*30+$hour_hand_rate*$m - $minute_hand_rate*$m)) % 360;
    return $deg > 180 ? 360-$deg : $deg;
}


ok ( clock_angle("03:10") == 35, "Example 1");
ok ( clock_angle("04:00") == 120 , "Example 2");
ok ( clock_angle("12:00") == 0 , "noon");
ok ( clock_angle("06:00") == 180, "6 o'clock");
ok ( clock_angle("09:00") == 90, "9 o'clock");
