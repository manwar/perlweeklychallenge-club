#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two events start and end time.
Write a script to find out if there is a conflict between the two events. A conflict happens when two events have some non-empty intersection.
Example 1

Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true

Both events overlap from "11:00" to "12:00".

Example 2

Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false

Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty, exact boundaries touching is not a conflict.

Example 3

Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true
Both events overlap from 14:30 to 15:30.

Example 4

Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false

There is a 1-minute gap from "09:00" to "09:01".


Example 5

Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: true

They overlap from "00:00" to "00:30".
=cut

use Time::Piece;
use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;
is(conflict_events([("10:00", "12:00")], [("11:00", "13:00")]), true, "Example 1");
is(conflict_events([("09:00", "10:30")], [("10:30", "12:00")]), false, "Example 2");
is(conflict_events([("14:00", "15:30")], [("14:30", "16:00")]), true, "Example 3");
is(conflict_events([("08:00", "09:00")], [("09:01", "10:00")]), false, "Example 4");
is(conflict_events([("23:30", "00:30")], [("00:00", "01:00")]), true, "Example 5");

done_testing();

sub conflict_events
{
     my ($event_1_aref, $event_2_aref) = @_;
     my $time_format = '%H:%M';
     my @first = map Time::Piece->strptime($_, $time_format), @$event_1_aref;
     my @second = map Time::Piece->strptime($_, $time_format), @$event_2_aref;

     return $first[1] > $second[0] ? true : false;
}
