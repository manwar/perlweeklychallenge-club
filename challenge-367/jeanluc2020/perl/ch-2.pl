#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/#TASK2
#
# Task 2: Conflict Events
# =======================
#
# You are given two events start and end time.
#
# Write a script to find out if there is a conflict between the two events. A
# conflict happens when two events have some non-empty intersection.
#
## Example 1
##
## Input: @event1 = ("10:00", "12:00")
##        @event2 = ("11:00", "13:00")
## Output: true
##
## Both events overlap from "11:00" to "12:00".
#
## Example 2
##
## Input: @event1 = ("09:00", "10:30")
##        @event2 = ("10:30", "12:00")
## Output: false
##
## Event1 ends exactly at 10:30 when Event2 starts.
## Since the problem defines intersection as non-empty, exact boundaries touching is not a conflict.
#
## Example 3
##
## Input: @event1 = ("14:00", "15:30")
##        @event2 = ("14:30", "16:00")
## Output: true
##
## Both events overlap from 14:30 to 15:30.
#
## Example 4
##
## Input: @event1 = ("08:00", "09:00")
##        @event2 = ("09:01", "10:00")
## Output: false
##
## There is a 1-minute gap from "09:00" to "09:01".
#
## Example 5
##
## Input: @event1 = ("23:30", "00:30")
##        @event2 = ("00:00", "01:00")
## Output: true
##
## They overlap from "00:00" to "00:30".
#
############################################################
##
## discussion
##
############################################################
#
# For easier comparison, we translate all times hh:mm into
# minutes since start of day. Then we jump into checking some
# special cases:
# 1. We check whether any of the dates wrap into the next
#    day, like ["23:30", "00:30"] does. If both dates wrap,
#    we surely have overlap at 00:00, so we can catch that
#    right away.
#    Then we check wether the non-wrapping date overlaps the
#    wrapping one.
# 2. If both dates don't wrap and have the same start time,
#    that will make the dates overlap right away.
# 3. If the first event starts before the second, the two
#    events to overlap once the other one starts before this
#    one ends.
# 4. Now we only need to check the case where the second event
#    starts before the first one in the same manner and we're
#    done.

use v5.36;

conflict_events(["10:00", "12:00"], ["11:00", "13:00"]);
conflict_events(["09:00", "10:30"], ["10:30", "12:00"]);
conflict_events(["14:00", "15:30"], ["14:30", "16:00"]);
conflict_events(["08:00", "09:00"], ["09:01", "10:00"]);
conflict_events(["23:30", "00:30"], ["00:00", "01:00"]);

sub conflict_events($event1, $event2) {
    print "Input: ($event1->[0], $event1->[1]), ";
    say "($event2->[0], $event2->[1])";
    my $e1 = [ time_to_minutes($event1->[0]), time_to_minutes($event1->[1]) ];
    my $e2 = [ time_to_minutes($event2->[0]), time_to_minutes($event2->[1]) ];
    my $e1_wraps = $e1->[0] > $e1->[1] ? 1 : 0;
    my $e2_wraps = $e2->[0] > $e2->[1] ? 1 : 0;
    return say "Output: true" if $e1_wraps && $e2_wraps;
    if($e1_wraps) {
        return say "Output: true" if $e2->[0] < $e1->[1];
        return say "Output: true" if $e2->[2] > $e1->[0];
        return say "Output: false";
    }
    if($e2_wraps) {
        return say "Output: true" if $e1->[0] < $e2->[1];
        return say "Output: true" if $e1->[2] > $e2->[0];
        return say "Output: false";
    }
    return say "Output: true" if $e1->[0] == $e2->[0];
    if($e1->[0] < $e2->[0]) {
        return say "Output: true" if $e1->[1] > $e2->[0];
        return say "Output: false";
    } else {
        return say "Output: true" if $e2->[1] > $e1->[0];
        return say "Output: false";
    }
}

sub time_to_minutes($str) {
    my ($h, $m) = split /:/, $str;
    return 60 * $h + $m;
}
