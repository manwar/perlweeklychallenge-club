#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @time_pairs = (
    [ "02:30", "02:45" ],
    [ "11:55", "12:15" ],
    [ "09:00", "13:00" ],
    [ "23:45", "00:30" ],
    [ "14:20", "15:25" ]
);

print("\n");
foreach my $time_pair (@time_pairs){
    printf(
        "Input: \$source = \"%s\"\n       \$target = \"%s\"\nOutput: %d\n\n",
        $time_pair->[0],
        $time_pair->[1],
        ops_to_make_time_difference(@{$time_pair})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a pair of times in the format "HH:MM" where "HH" ranges from "00" to
# "24", and "MM" ranges from "00" to "59", calculate the number of operations
# needed to construct the difference between the two times, where each
# operation consists of adding minutes in blocks of 60, 15, 5, or 1
# Takes two arguments:
# * The first time to examine (e.g. "23:45")
# * The second time to examine (e.g. "00:30")
# Returns:
# * The number of operations required to construct the difference in minutes
#   between the two, where each operation is an addition of minutes in
#   quantities defined above (e.g. 3)
################################################################################
sub ops_to_make_time_difference{
    my ($start, $end) = @ARG;

    my $diff;
    my $ops = 0;

    # Split the times into hours and minutes
    $start = [ split(/:/, $start) ];
    $end = [ split(/:/, $end) ];

    # If the hour of the end time appears to be less
    # than that of the start time, assume that it's
    # from the next day
    $end->[0] += 24
        if($end->[0] < $start->[0]);

    # Convert hours and minutes to just minutes, and
    # calculate the difference
    $diff = ($end->[0] * 60 + $end->[1]) - ($start->[0] * 60 + $start->[1]);

    # Loop over each unit of minutes, determining how
    # many of each are required to equal the difference
    for my $unit_size (60, 15, 5, 1){
        $ops += int($diff / $unit_size);
        $diff = $diff % $unit_size;
    }

    return($ops);

}



