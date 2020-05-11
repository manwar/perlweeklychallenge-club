#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

# Write a script to find out the DayLight gain/loss in the month of December 2019
# as compared to November 2019 in the city of London. 
# You can find out sunrise and sunset data for November 2019 and December 2019 for London.
my @hour_delta;
while (<DATA>) {
    chomp;
    my ($day,$rise,$set) = /[^,]+/g;
    if (defined $day && $day=~/^\d+$/ && $day < 32) {
        $set  =~ /(..):(..)/;
        $set  = $1*60+$2;
        $rise =~ /(..):(..)/;
        $rise = $1*60+$2;
        if (!defined $hour_delta[$day]) {
            $hour_delta[$day]  = $set - $rise;
        } else {
            $hour_delta[$day] -= ($set - $rise);
        }
    }
    
}
my $total_hours;
for my $day (1..30) {
    $total_hours += $hour_delta[$day];

    my $hours = 0|$hour_delta[$day] / 60;
    my $mins  = $hour_delta[$day]   % 60;

    printf ("Day %02d: Δ = %02d:%02d\n",$day, $hours, $mins);
}

__DATA__
Nov,Sunrise,Sunset
1,06:53,16:34
2,06:55,16:32
3,06:56,16:30
4,06:58,16:28
5,07:00,16:27
6,07:02,16:25
7,07:03,16:23
8,07:05,16:22
9,07:07,16:20
10,07:09,16:18
11,07:10,16:17
12,07:12,16:15
13,07:14,16:14
14,07:16,16:12
15,07:17,16:11
16,07:19,16:10
17,07:21,16:08
18,07:22,16:07
19,07:24,16:06
20,07:26,16:05
21,07:27,16:04
22,07:29,16:03
23,07:31,16:01
24,07:32,16:00
25,07:34,15:59
26,07:35,15:59
27,07:37,15:58
28,07:38,15:57
29,07:40,15:56
30,07:41,15:55

Dec,Sunrise,Sunset
1,07:43,15:55
2,07:44,15:54
3,07:46,15:53
4,07:47,15:53
5,07:48,15:53
6,07:49,15:52
7,07:51,15:52
8,07:52,15:51
9,07:53,15:51
10,07:54,15:51
11,07:55,15:51
12,07:56,15:51
13,07:57,15:51
14,07:58,15:51
15,07:59,15:51
16,08:00,15:51
17,08:00,15:51
18,08:01,15:52
19,08:02,15:52
20,08:02,15:52
21,08:03,15:53
22,08:04,15:53
23,08:04,15:54
24,08:04,15:54
25,08:05,15:55
26,08:05,15:56
27,08:05,15:57
28,08:06,15:57
29,08:06,15:58
30,08:06,15:59
31,08:06,16:00