#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @event_pairs = (
    [
        [ "10:00", "12:00" ],
        [ "11:00", "13:00" ]
    ],
    [
        [ "09:00", "10:30" ],
        [ "10:30", "12:00" ]
    ],
    [
        [ "14:00", "15:30" ],
        [ "14:30", "16:00" ]
    ],
    [
        [ "08:00", "09:00" ],
        [ "09:01", "10:00" ]
    ],
    [
        [ "23:30", "00:30" ],
        [ "00:00", "01:00" ]
    ]
);

print("\n");
foreach my $event_pair (@event_pairs){
    printf(
        "Input: \@event1 = (\%s)\n       \@event2 = (%s)\nOutput: %s\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$event_pair->[0]}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$event_pair->[1]}
            )
        ),
        do_events_overlap(@{$event_pair}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two events whose start and end times are defined in HH:MM, 24-hour
# format (i.e. 00:00-23:59) determine whether the events overlap and conflict
# with each other; note that one event beginning at the same time another ends
# does not count as an overlap
# Takes two arguments:
# * A ref to an array with the start and end times of the first event (e.g.
#   [ "23:30", "00:30" ] )
# * A ref to an array with the start and end times of the second event (e.g
#   [ "00:00", "01:00" ] )
# Returns:
# * 0 if the two events do not overlap
# * 1 if the two events overlap (as would be the case in the example above)
################################################################################
sub do_events_overlap{
    # Convert the specified times to seconds
    # since the start of the day, en passant
    my @events = map(
        [ map(time_to_seconds($_), @{$_}) ],
        @ARG
    );

    # Adjust the start time of events that span
    # midnight, making them appear to start on
    # the previous day
    $events[0][0] -= 86400
        if($events[0][0] > $events[0][1]);
    $events[1][0] -= 86400
        if($events[1][0] > $events[1][1]);

    return(
        # Is the end of the first event somewhere
        # within the range of the second?
        (($events[0][1] > $events[1][0]) && ($events[0][1] < $events[1][1]))
        ||
        # Or is the end of the second event somewhere
        # within the range of the first?
        (($events[1][1] > $events[0][0]) && ($events[1][1] < $events[0][1]))
        ?
            1
            :
            0
    );

}



################################################################################
# Convert a time in HH:MM, 24-hour format (i.e. 00:00-23:59) to the number of
# seconds since the start of the day (00:00)
# Takes one argument:
# * A string containing a time in HH:MM format (e.g. 12:01)
# Returns:
# * The number of seconds since 00:00 described by the supplied time (e.g.
#   43260)
################################################################################
sub time_to_seconds{
    my($hr, $min) = split(/:/, shift());

    return(3600 * $hr + 60 * $min);

}



