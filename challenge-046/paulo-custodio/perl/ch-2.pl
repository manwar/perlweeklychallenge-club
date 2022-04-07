#!/usr/bin/env perl

# Challenge 046
#
# TASK #2
# Is the room open?
# There are 500 rooms in a hotel with 500 employees having keys to all the rooms.
# The first employee opened main entrance door of all the rooms. The second
# employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500. The
# third employee then closed the door if it was opened or opened the door if it
# was closed of rooms 3,6,9,12,15 and so on to 500. Similarly the fourth employee
# did the same as the third but only room numbers 4,8,12,16 and so on to 500.
# This goes on until all employees has had a turn.
#
# Write a script to find out all the rooms still open at the end.

use Modern::Perl;

my @rooms = (0, (0)x500);
for my $emp (1..500) {
    for (my $door = $emp; $door < @rooms; $door += $emp) {
        $rooms[$door] = 1-$rooms[$door];
    }
}
my @doors = map {$_->[0]} grep {$_->[1]} map {[$_ => $rooms[$_]]} (1..500);
say join(", ", @doors);
