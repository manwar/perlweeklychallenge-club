#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given time $T in the format hh:mm. Write a script to find the smaller angle formed by the hands of an analog clock at a given time. HINT: A analog clock is divided up into 12 sectors. One sector represents 30 degree (360/12 = 30).
Example
Input: $T = '03:10' Output: 35 degree
The distance between the 2 and the 3 on the clock is 30 degree. For the 10 minutes i.e. 1/6 of an hour that have passed.
The hour hand has also moved 1/6 of the distance between the 3 and the 4, which adds 5 degree (1/6 of 30).
The total measure of the angle is 35 degree.

Input: $T = '04:00' Output: 120 degree
=cut





my %MINUTES;
@MINUTES{0 .. 59} = map $_ * 6, 0 .. 59;

my %HOURS;
@HOURS{0 .. 11} = map $_ * 30, 0 .. 11;


sub clock_angle
{
     my $time = $_[0];
     my ($hour, $min) = map $_ * 1, split(/:/, $time);
     $hour = $hour >= 12 ? $hour - 12 : $hour; 
     my $hour_hand = $HOURS{$hour} + ($min/60) * 30;
     my $minute_hand = $MINUTES{$min};
     my $angle = abs($hour_hand - $minute_hand);
     $angle = $angle > 180 ? 360 - $angle : $angle;
     return $angle;
}



for my $time ( '0000' .. '2359' )
{
     next if unpack("xxA2", $time) > 59;

     my $time_formatted = join(':',unpack("A2A2",$time)); 
     print join(' -> ', $time_formatted, clock_angle($time_formatted)), $/;
}