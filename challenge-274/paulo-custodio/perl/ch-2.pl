#!/usr/bin/env perl

# Challenge 274
#
# Task 2: Bus Route
# Submitted by: Peter Campbell Smith
# Several bus routes start from a bus stop near my home, and go to the same stop
# in town. They each run to a set timetable, but they take different times to
# get into town.
#
# Write a script to find the times - if any - I should let one bus leave and
# catch a strictly later one in order to get into town strictly sooner.
#
# An input timetable consists of the service interval, the offset within the
# hour, and the duration of the trip.
#
# Example 1
# Input: [ [12, 11, 41], [15, 5, 35] ]
# Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
#
# Route 1 leaves every 12 minutes, starting at 11 minutes past the hour
# (so 11, 23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes,
# starting at 5 minutes past (5, 20, ...) and takes 35 minutes.
#
# At 45 minutes past the hour I could take the route 1 bus at 47 past the hour,
# arriving at 28 minutes past the following hour, but if I wait for the
# route 2 bus at 50 past I will get to town sooner, at 25 minutes past the
# next hour.
# Example 2
# Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
# Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]

use Modern::Perl;

my @routes = map {[split ' ', $_]} split /,/, "@ARGV";

say join ' ', skip_minutes(@routes);

sub skip_minutes {
    my(@routes) = @_;
    my @buses = calc_buses(@routes);
    my @out;
    for (0..59) {
        push @out, $_ if skip_sooner($_, @buses);
    }
    return @out;
}

# build sorted list of [start-time,end-time] for all routes
sub calc_buses {
    my(@routes) = @_;
    my @buses;
    for (@routes) {
        my($interval, $start, $duration) = @$_;
        for (my $time = $start; $time < 120; $time += $interval) {
            push @buses, [$time, $time+$duration];
        }
    }
    return sort {$a->[0] <=> $b->[0]} @buses;
}

# skip bus at this minute to arrive sooner
sub skip_sooner {
    my($minute, @buses) = @_;

    # get first bus that matches
    my($start_time, $end_time);
    for (@buses) {
        my($bus_start, $bus_end) = @$_;
        if ($bus_start >= $minute) {
            ($start_time, $end_time) = ($bus_start, $bus_end);
            last;
        }
    }

    # check if a later bus arrives sooner
    for (@buses) {
        my($bus_start, $bus_end) = @$_;
        return 1 if $bus_start > $start_time && $bus_end < $end_time;
    }

    return 0;
}
