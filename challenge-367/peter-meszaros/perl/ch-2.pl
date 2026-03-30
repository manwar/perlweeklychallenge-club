#!/usr/bin/env perl
#
=head1 Task 2: Conflict Events

Submitted by: Mohammad Sajid Anwar

You are given two events start and end time.  Write a script to find out if
there is a conflict between the two events. A conflict happens when two events
have some non-empty intersection.

=head2 Example 1

    Input: @event1 = ("10:00", "12:00")
           @event2 = ("11:00", "13:00")
    Output: true

    Both events overlap from "11:00" to "12:00".

=head2 Example 2

    Input: @event1 = ("09:00", "10:30")
           @event2 = ("10:30", "12:00")
    Output: false

    Event1 ends exactly at 10:30 when Event2 starts.
    Since the problem defines intersection as non-empty, exact boundaries
    touching is not a conflict.

=head2 Example 3

    Input: @event1 = ("14:00", "15:30")
           @event2 = ("14:30", "16:00")
    Output: true

    Both events overlap from 14:30 to 15:30.

=head2 Example 4

    Input: @event1 = ("08:00", "09:00")
           @event2 = ("09:01", "10:00")
    Output: false

    There is a 1-minute gap from "09:00" to "09:01".

=head2 Example 5

    Input: @event1 = ("23:30", "00:30")
           @event2 = ("00:00", "01:00")
    Output: true

    They overlap from "00:00" to "00:30".

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[["10:00", "12:00"], ["11:00", "13:00"]],  true, "Example 1"],
    [[["09:00", "10:30"], ["10:30", "12:00"]], false, "Example 2"],
    [[["14:00", "15:30"], ["14:30", "16:00"]],  true, "Example 3"],
    [[["08:00", "09:00"], ["09:01", "10:00"]], false, "Example 4"],
    [[["23:30", "00:30"], ["00:00", "01:00"]],  true, "Example 5"],
];

sub conflict_events
{
    sub time_to_minutes
    {
        my $time = shift;
        my ($hours, $minutes) = split /:/, $time;
        return $hours * 60 + $minutes;
    }

    my $event1 = $_[0]->[0];
    my $event2 = $_[0]->[1];

    my ($start1, $end1) = map { time_to_minutes($_) } @$event1;
    my ($start2, $end2) = map { time_to_minutes($_) } @$event2;

    $start1 -= 24 * 60 if $end1 < $start1;
    $start2 -= 24 * 60 if $end2 < $start2;

    return ($start1 < $end2 && $start2 < $end1) ? true : false;
}

for (@$cases) {
    is(conflict_events($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
