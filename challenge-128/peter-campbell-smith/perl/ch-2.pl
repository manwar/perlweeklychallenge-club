#!/usr/bin/perl

# Peter Campbell Smith - 2021-08-30
# PWC 128 task 2

use strict;
use warnings;

# You are given two arrays of arrival and departure times of trains at a railway station.
# Write a script to find out the minimum number of platforms needed so that no train needs 
# to wait.
#
# Example 2:
# Input: @arrivals   = (10:20, 11:00, 11:10, 12:20, 16:20, 19:00)
#        @departures = (10:30, 13:20, 12:40, 12:50, 20:20, 21:20)

my (@arrivals, @departures, $train, %trains, $max_platforms, $now_platforms, $event);

@arrivals   = qw[10:20 11:00 11:10 12:20 16:20 19:00];
@departures = qw[10:30 13:20 12:40 12:50 20:20 21:20];

# Assume that all times are on the same day - ie trains do not travel across midnight

# Make a hash (%trains) with all events - ie arrival and departure times - as the keys.
# The value of each hash element is the change in platforms need, ie +1 for an arrival 
# and -1 for a departure.

# There could be two events happening at the same time, so the hash key needs to be suffixed
# with a unique number.  Also, it would be dangerous for a train to arrive in a platform at the same time
# as an earlier train leaves, so we need consider arrivals at a given time before departures and
# so the hash keys have to sort arrivals at a given time before departures.  So a typical hash key
# is 12:20-a3 (the 4th train arrives at 12:20) or 12:30-d6 (the 5th train departs at 12:30).

# create the hash
for $train (0 .. $#arrivals) {
	$trains{"$arrivals[$train]-a$train"} = 1;
	$trains{"$departures[$train]-d$train"} = -1;
}

# loop over the events in time order
$max_platforms = 0;
$now_platforms = 0;   # number of platforms needed after each event

for $event (sort keys %trains) {
	$now_platforms += $trains{$event};
	$max_platforms = $now_platforms if $now_platforms > $max_platforms;
}

# show input and output
print 'Arrivals:   ' . join(' ', @arrivals) . "\nDepartures: " . join(' ', @departures)  . 
	"\n\nWe need $max_platforms platforms\n";
	