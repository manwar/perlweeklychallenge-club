#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @timetables = (
    [
        [ 12, 11, 41 ],
        [ 15,  5, 35 ]
    ],
    [
        [ 12,  3, 41 ],
        [ 15,  9, 35 ],
        [ 30,  5, 25 ]
    ]
);

print("\n");
foreach my $timetable (@timetables){
    printf(
        "Input: [ %s ]\nOutput: [ %s ]\n\n",
        join(
            ", ",
            map(
                "[ " . join(", ", @{$_}) . " ]",
                @{$timetable}
            )
        ),
        join(", ", bus_skip_times($timetable))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of arrays of integers that define a bus timetable in terms of
# headway between runs, the time of the first run of the hour, and the time it
# takes to reach a destination downtown, determine during which minutes of the
# hour a rider should wait and skip the next bus in order to take a later bus
# that arrives sooner
# Takes one argument:
# * A ref to an array of arrays of integers that define a bus timetable (e.g.
#       [
#           [ 12,  3, 41 ],  # [ Headway, Initial offset, Length of run ]
#           [ 15,  9, 35 ],
#           [ 30,  5, 25 ]
#       ]
#   )
# Returns:
# * A list of minutes within an hour in which a rider should wait and skip the
#   next bus in favor of the one after, which will arrive at their destination
#   sooner (e.g. ( 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48,
#   49, 50, 51, 55, 56, 57, 58, 59 ) )
################################################################################
sub bus_skip_times{
    my $timetable = shift();

    my $lookahead_limit = $#$timetable;
    my %arrival_times;
    my @skip_times;

    # Create a table of unique arrival times,
    # keyed by departure time
    foreach my $route (@{$timetable}){
        my $departure_time = $route->[1];

        while($departure_time < 60){
            if($arrival_times{$departure_time}){
                # There is an existing arrival time for this
                # departure time
                if(
                    $arrival_times{$departure_time}
                    >
                    ($departure_time + $route->[2])
                ){
                    # This arrival time would be sooner- store it
                    # instead
                    $arrival_times{$departure_time} =
                        $departure_time + $route->[2];
                }
            } else{
                # No existing arrival time for this departure
                # time
                $arrival_times{$departure_time} =
                    $departure_time + $route->[2];
            }

            # Advance the departure time by the given
            # headway
            $departure_time += $route->[0];
        }

        # Add an initial departure time for the NEXT
        # hour, in case the next bus not to skip
        # departs then
        $departure_time = $route->[1] + 60;
        if($arrival_times{$departure_time}){
            # There is an existing arrival time for this
            # departure time
            if(
                $arrival_times{$departure_time}
                >
                ($departure_time + $route->[2])
            ){
                # This arrival time would be sooner- store it
                # instead
                $arrival_times{$departure_time} =
                    $departure_time + $route->[2];
            }
        } else{
            # No existing arrival time for this departure
            # time
            $arrival_times{$departure_time} =
                $departure_time + $route->[2];
        }

    }

    # Briefly store a sorted list of all
    # departure times
    @skip_times = sort({ $a <=> $b } keys(%arrival_times));

    # Then replace it with the list of times to
    # skip...
    @skip_times = map(
        {
            my $arrival_time = $arrival_times{$skip_times[$_]};
            my $skip = undef;

            # Scan ahead of the current index for more
            # optimal arrival times- but only for so many
            # departure times as there are routes in the
            # timetable
            for my $index (
                $_ + 1
                ..
                (
                    $_ + $lookahead_limit <= $#skip_times ?
                        $_ + $lookahead_limit
                        :
                        $#skip_times
                )
            ){
                if(
                    $arrival_times{$skip_times[$index]}
                    < 
                    $arrival_time
                ){
                    # A more optimal arrival time was found; mark
                    # THIS departure time as skippable and stop
                    # searching
                    $skip = $skip_times[$_];
                    last;
                }
            }

            defined($skip) ?
                # This departure time is to be skipped...
                (
                    # ...so make a list of times...
                    (
                        # ...checking to see if this isn't the first
                        # departure time...
                        $_ ?
                            # ...if it's not, start just after the
                            # previous departure time...
                            ($skip_times[$_ - 1] + 1)
                            :
                            # ...if it is, start from zero...
                            0
                    )
                    ..
                    # ...and continue to the current time to be
                    # skipped
                    $skip
                )
                :
                # This departure time is NOT to be skipped...
                # return an empty list
                ();
        }

        # Get a list of indices within the list of
        # departure times, excluding the last one
        0 .. $#skip_times - 1
    );

    # Remove any trailing times that are past the
    # end of the hour (as happens if an initial
    # departure time, occuring in the next hour,
    # is to be skipped)
    while($skip_times[-1] > 59){
        pop(@skip_times);
    }

    return(@skip_times);

}



