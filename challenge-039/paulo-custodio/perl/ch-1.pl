#!/usr/bin/env perl

# Challenge 039
#
# TASK #1
# A guest house had a policy that the light remain ON as long as the at least
# one guest is in the house. There is guest book which tracks all guest in/out
# time. Write a script to find out how long in minutes the light were ON.
# Guest Book
# 1) Alex    IN: 09:10 OUT: 09:45
# 2) Arnold  IN: 09:15 OUT: 09:33
# 3) Bob     IN: 09:22 OUT: 09:55
# 4) Charlie IN: 09:25 OUT: 10:05
# 5) Steve   IN: 09:33 OUT: 10:01
# 6) Roger   IN: 09:44 OUT: 10:12
# 7) David   IN: 09:57 OUT: 10:23
# 8) Neil    IN: 10:01 OUT: 10:19
# 9) Chris   IN: 10:10 OUT: 11:00

use Modern::Perl;
use Time::Interval;
use Date::Parse;

my $min_intervals = coalesce([
                ['09:10', '09:45'],
                ['09:15', '09:33'],
                ['09:22', '09:55'],
                ['09:25', '10:05'],
                ['09:33', '10:01'],
                ['09:44', '10:12'],
                ['09:57', '10:23'],
                ['10:01', '10:19'],
                ['10:10', '11:00'],
]);

my $minutes = 0;
for (@$min_intervals) {
    my $s = str2time($_->[0])/60;
    my $e = str2time($_->[1])/60;
    $minutes += $e-$s;
}
say $minutes;
